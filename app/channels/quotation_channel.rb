class QuotationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    quotation = Quotation.find(params[:id])
    stream_for quotation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
