class AddToBillsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bills"
  end
end
