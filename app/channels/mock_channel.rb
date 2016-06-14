class MockChannel < ApplicationCable::Channel
  def subscribed
    logger.debug "subscribed to MockChannel #{params[:id]}"
    stream_from "mock_#{params[:id]}"
  end

  def receive(data)
    logger.debug data
  end
end
