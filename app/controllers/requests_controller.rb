class RequestsController < ApplicationController

  def show
    @mock = Mock.find( id: params[:id])
    response.content_type = @mock.contenttype
    render :json => @mock.body, :status => @mock.statuscode
  end

end