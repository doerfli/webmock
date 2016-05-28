class MocksController < ApplicationController

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
      format.json { render :json => @mock.latest_requests(16) }
    end
  end

  private

    def mock_params
      params.require(:mock).permit(:statuscode, :contenttype, :body, customheaders: [:name, :value])
    end

end