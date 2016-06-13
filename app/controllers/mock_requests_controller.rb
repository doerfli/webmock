class MockRequestsController < ApplicationController

  def raw_body
    req = MockRequest.find( id: params[:id])
    response.content_type = 'text/plain'
    render :text => req.body
  end

end