class RequestsController < ApplicationController

  def show
    @mock = Mock.find( id: params[:id])

    case @mock.contetype
      when 'application/json'
        response.content_type = @mock.contenttype
        render :json => @mock.body, :status => @mock.statuscode

      when 'application/xml'
        response.content_type = @mock.contenttype
        render :xml => @mock.body, :status => @mock.statuscode

      when 'text/html'
        response.content_type = @mock.contenttype
        render @mock.body, :status => @mock.statuscode

      else
        response.content_type = 'application/json'
        render :json => @mock.body, :status => @mock.statuscode
    end

  end

end