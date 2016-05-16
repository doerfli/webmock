class MockRequestsController < ApplicationController

  def show
    mock = Mock.find( id: params[:id])

    MockRequest.new(
        remote_address: request.remote_ip,
        method: request.method,
        mock: mock
    ).save

    response.content_type = mock.contenttype
    render plain: mock.body, :status => mock.statuscode
  end

end