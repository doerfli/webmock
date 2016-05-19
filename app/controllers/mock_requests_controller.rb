class MockRequestsController < ApplicationController

  # no CSRF checks on #show
  skip_before_filter :verify_authenticity_token, :only => [:show]

  def show
    mock = Mock.find( id: params[:id])

    MockRequest.new(
        remote_address: request.remote_ip,
        method: request.method,
        # headers sent from client as prefixed with HTTP_ and we only want to store those and remove the HTTP_ for storing
        headers: Hash[request.headers.env.select{|h,_| h =~ /^HTTP_(.+)/ }.map{|k,v| [k.match(/^HTTP_(.+)/)[1],v.to_s]}],
        mock: mock,
        body: request.raw_post
    ).save

    response.content_type = mock.contenttype
    render plain: mock.body, :status => mock.statuscode
  end

end