class MocksController < ApplicationController

  def index
    @new_mock = Mock.new
    @mocks = Mock.all
  end

  def create
    mock = Mock.new(mock_params)
    mock.id = SecureRandom.uuid
    mock.save

    redirect_to mock
  end

  def show
    @mock = Mock.find( id: params[:id])
  end

  def history
    @mock = Mock.find( id: params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @mock.mock_requests.order_by(:created_at => 'desc').limit(16).map{|r| r.only_members( :_id, :method, :created_at, :remote_address, :created_at_date, :created_at_time, :headers, :body) } }
    end
  end

  private

    def mock_params
      params.require(:mock).permit(:statuscode, :contenttype, :body)
    end

end