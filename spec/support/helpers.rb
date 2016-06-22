module Helpers
  def send_mock_request(mockid, type)
    t = URI.parse(current_url)
    uri = URI("http://#{t.host}:#{t.port}/#{mockid}")

    case type
      when :get
        Net::HTTP.get(uri)

      when :post
        Net::HTTP.post_form(uri, 'a' => 'b')
    end

  end
end

RSpec.configure do |c|
  c.include Helpers
end