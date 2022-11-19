class MessagesController < ApplicationController
  def index
    # lista de conversas
    # listar todas as quotations (@quotations)
    @quotations = policy_scope(Quotation)
  end

  def messages
    # lista de mesnagens dos usuários de uma quotation
    # mostrar as mensagens (@messagens)
    @quotation = Quotation.find(params[:quotation_id])
    @messages = @quotation.messages
    @message = Message.new
    authorize @quotation, policy_class: MessagePolicy
  end

  def create
    @quotation = Quotation.find(params[:quotation_id])
    @message = Message.new(message_params)
    @message.quotation = @quotation
    @message.user = current_user
    if @message.save
      QuotationChannel.broadcast_to(
        @quotation,
        render_to_string(partial: "message", locals: { message: @message })
      )
      head :ok
    else
      render "messages/index", status: :unprocessable_entity
    end
    authorize @quotation, policy_class: MessagePolicy
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
