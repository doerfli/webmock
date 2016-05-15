class RequestsController < ApplicationController

  def show
    @mock = Mock.find( id: params[:id])

    case @mock.contenttype
      when 'application/json'
        response.content_type = @mock.contenttype

      when 'application/xml','text/xml'
        response.content_type = @mock.contenttype

      when 'text/html'
        response.content_type = @mock.contenttype

      else
        response.content_type = 'application/json'
    end

    render plain: @mock.body, :status => @mock.statuscode
  end

end