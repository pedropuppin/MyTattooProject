class MessagesController < ApplicationController
  def index
    # lista de conversas
    # listar todas as quotations (@quotations)
    @quotations = policy_scope(Quotation)
  end

  def messages
    # lista de mesnagens dos usuários de uma quotation
    # mostrar as mensagens (@messagens)
  end

  def create
    @quotation = Quotation.find(params[:quotation_id])
    @message = Message.new(message_params)
    @message.quotation = @quotation
    @message.user = current_user
    if @message.save
      redirect_to quotation_messages_path(@quotation)
    else
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
