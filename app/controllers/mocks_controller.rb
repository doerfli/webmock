class MocksController < ApplicationController

  include ApplicationHelper

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

  def history
    @mock = Mock.find( id: params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => latest_requests(@mock, 16) }
    end
  end

  def search
    raise 'not yet implemented'
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