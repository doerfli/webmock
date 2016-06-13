class MocksController < ApplicationController

  include ApplicationHelper

  # no CSRF checks on #show
  skip_before_action :verify_authenticity_token, :only => [:replay]

  helper_method :latest_requests

  def index
    @new_mock = Mock.new
    @mocks = Mock.all
  end

  def create
    mock = Mock.new(mock_params)
    mock.id = SecureRandom.uuid
    mock.remove_empty_headers
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

    unless mock.customheaders.nil?
      mock.customheaders.each{ |h|
        response.headers[h[:name]] = h[:value]
      }
    end

    render plain: mock.body, :status => mock.statuscode
  end

  def history
    @mock = Mock.find( id: params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => latest_requests(@mock, 16) }
    end
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
      redirect_to root_url
    end
  end

  private

    def mock_params
      params.require(:mock).permit(:statuscode, :contenttype, :body, customheaders: [:name, :value])
    end

    def latest_requests(mock, num = 16)
      mock.mock_requests.order_by(:created_at => 'desc').limit(num).map{|r|
        t = r.only_members(
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

        t[:body] = pretty_print_body( t[:contenttype], t[:body])
        logger.debug t
        t
      }
    end

end