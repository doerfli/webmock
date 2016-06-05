module ApplicationHelper

  def pretty_print_body(contenttype, body)
    begin
      case contenttype
        when 'application/json'
          JSON.pretty_generate JSON.parse body
        else
          body
      end
    rescue Exception => e # ignore error during formatting (most likely the body does not adhere to the expected format)
      logger.debug "format error #{e}"
      body
    end

  end

end
