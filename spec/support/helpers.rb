module Helpers
  def send_mock_request(mockid)
    t = URI.parse(current_url)
    uri = URI("http://#{t.host}:#{t.port}/#{mockid}")
    Net::HTTP.get(uri)
  end
end

RSpec.configure do |c|
  c.include Helpers
end