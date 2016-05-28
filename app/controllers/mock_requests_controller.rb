class MockRequestsController < ApplicationController

  # no CSRF checks on #show
  skip_before_filter :verify_authenticity_token, :only => [:show]

  def show
    mock = Mock.find( id: params[:id])

    mockreq = MockRequest.new(
        remote_address: request.remote_ip,
        method: request.method,
        # headers sent from client as prefixed with HTTP_ and we only want to store those and remove the HTTP_ for storing
        headers: Hash[request.headers.env.select{|h,_| h =~ /^HTTP_(.+)/ }.map{|k,v| [k.match(/^HTTP_(.+)/)[1],v.to_s]}],
        mock: mock,
        body: request.raw_post,
        body_size: request.raw_post.size,
        url: request.original_url
    )
    mockreq.query_params = request.query_parameters() unless request.query_parameters.empty?
    mockreq.save

    response.content_type = mock.contenttype

    unless mock.customheaders.nil?
      mock.customheaders.each{ |h|
        response.headers[h[:name]] = h[:value]
      }
    end

    render plain: mock.body, :status => mock.statuscode
  end

end