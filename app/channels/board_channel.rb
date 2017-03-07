class BoardChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def draw(data)
    ActionCable.server.broadcast "room_channel", data: data['data']
  end

  def clear(data)
    ActionCable.server.broadcast "room_channel", data: data['data']
  end
end
