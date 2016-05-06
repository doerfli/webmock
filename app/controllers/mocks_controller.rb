class MocksController < ApplicationController

  def index
    @new_mock = Mock.new
    @mocks = Mock.all
  end

  def create
    mock = Mock.new(mock_params)
    mock.id = SecureRandom.uuid
    mock.save
    flash[:new] = mock

    redirect_to mocks_path, change: ['result']
  end

  def show

  end

  private

    def mock_params
      params.require(:mock).permit(:statuscode, :contenttype, :body)
    end

end