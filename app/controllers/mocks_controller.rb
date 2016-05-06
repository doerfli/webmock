class MocksController < ApplicationController

  def index
    @new_mock = Mock.new
  end

  def create
    @mock = Mock.new(mock_params)
    @mock.save

    redirect_to :action => :index
  end

  private

    def mock_params
      params.require(:mock).permit(:statuscode, :contenttype, :body)
    end

end