require 'recaptcha/rails'

class MocksController < ApplicationController
  include ApplicationHelper
  include Recaptcha::ClientHelper

  # no CSRF checks on #show
  skip_before_action :verify_authenticity_token, :only => [:replay]
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :document_not_found

  helper_method :latest_requests

  def index
    @new_mock = Mock.new
    @new_mock = Mock.find( id: params[:clone]).clone if params[:clone]

    if Mock.created_last_hour(session.id).size > 60 and ! session.has_key?(:verified_human)
      logger.warn "session #{session.id} created more than 60 mocks in the last hour and needs to be verified to be human"
      session[:to_be_verified] = true
    else
      session[:to_be_verified] = false
    end
  end

  def create
    if session[:to_be_verified]
      if verify_recaptcha
        session[:verified_human] = true
      else
        logger.warn 'reCAPTCHA verification failed'
        flash[:alert_error] = 'Could not verify CAPTCHA. Please try again.'
        redirect_to root_path and return
      end
    end

    mock = Mock.new(mock_params)
    mock.id = SecureRandom.uuid
    mock.created_by_session = session.id
    mock.save

    flash[:alert_success] = "#{t('.msgsuccess')} #{view_context.link_to(mocklink_url(mock), mocklink_url(mock), { :target => '_blank'})}"
    redirect_to mock
  end

  def show
    @mock = Mock.find( id: params[:id])
  end

  def raw_body
    mock = Mock.find( id: params[:id])
    response.content_type = 'text/plain'
    render :text => mock.body
  end

  def replay
    mock = Mock.find( id: params[:id])

    unless mock.delay.nil?
      # delaying execution of mock by x seconds
      logger.debug "delaying replay by #{mock.delay} seconds"
      sleep(mock.delay.to_i)
    end

    mockreq = MockRequest.new(
        remote_address: request.remote_ip,
        method: request.method,
        # headers sent from client as prefixed with HTTP_ and we only want to store those and remove the HTTP_ for storing
        headers: Hash[request.headers.env.select{|h,_| h =~ /^HTTP_(.+)/ }.map{|k,v| [k.match(/^HTTP_(.+)/)[1],v.to_s]}],
        contenttype: request.content_type,
        mock: mock,
        body: request.raw_post,
        body_size: request.raw_post.size,
        url: request.original_url
    )
    mockreq.query_params = request.query_parameters() unless request.query_parameters.empty?
    mockreq.save

    response.content_type = mock.contenttype
    response.charset = mock.charset unless mock.charset.nil?

    unless mock.customheaders.nil?
      mock.customheaders.each{ |h|
        response.headers[h[:name]] = h[:value]
      }
    end

    # MockChannel.broadcast_to("123", title: "hello world", body: "something new");
    ActionCable.server.broadcast "mock_#{mock.id}", convert_mockreq_for_client(mockreq)

    render plain: mock.body, :status => mock.statuscode
  end

  def history
    @mock = Mock.find( id: params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => latest_requests(@mock, 50) }
    end
  end

  def destroy
    mock = Mock.find( id: params[:id])
    mock.destroy

    redirect_to root_path
  end

  def search
    mock = nil

    begin
      mock = Mock.find( id: params[:term])
    rescue Mongoid::Errors::DocumentNotFound
      # all good, no match found
      logger.debug 'no match found'
    end

    unless mock
      mocks = Mock.where( id: Regexp.new(params[:term]))
      logger.debug "found #{mocks.size} matches"
      mock = mocks.size == 1 ? mocks[0] : nil
    end

    if mock
      redirect_to mock
    else
      flash[:alert_warning] = t('error.search_no_match', term: params[:term])
      flash[:term] = params[:term]
      redirect_to root_path
    end
  end

  def document_not_found(exception)
    flash[:alert_error] = "Blimey - we searched the farthest corners of our database, but a mock with id '#{exception.params[0][:id]}' does not exist"
    redirect_to root_path
  end

  private

    def mock_params
      params.require(:mock).permit(:statuscode, :contenttype, :body, :delay, :charset, customheaders: [:name, :value])
    end

    def latest_requests(mock, num = 16)
      mock.mock_requests.order_by(:created_at => 'desc').limit(num).map{|r|
        t = convert_mockreq_for_client r
        logger.debug t
        t
      }
    end

    def convert_mockreq_for_client(r)
      c = r.only_members(
          :_id,
          :method,
          :url,
          :query_params_as_text,
          :created_at,
          :remote_address,
          :created_at_date,
          :created_at_time,
          :headers,
          :contenttype,
          :body,
          :body_size,
      )
      c[:body] = pretty_print_body(c[:contenttype], c[:body])
      c
    end

end