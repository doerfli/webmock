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

  private

    def mock_params
      params.require(:mock).permit(:statuscode, :contenttype, :body)
    end

end