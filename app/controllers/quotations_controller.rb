class QuotationsController < ApplicationController
  before_action :set_quotation, only: %i[show destroy]

  def index
    @quotations = policy_scope(Quotation)
  end

  def show
    # @quotations = Quotation.find(params[:id])
    @message = Message.new
    authorize @quotation
  end

  def new
    @quotation = Quotation.new
    @artist = User.find(params[:artist_id])
    authorize @quotation
  end

  def create
    @artist = User.find(params[:artist_id])
    @quotation = Quotation.new(quotations_params)
    @quotation.artist = @artist
    @quotation.user = current_user
    if @quotation.save
      redirect_to messages_index_path(quotation_id: @quotation.id) # redirecionar para o chat de conversa (rota - quotation_message_path)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @quotation
  end

  def destroy
    # @quotation = quotation.find(params[:id])
    @quotation.delete
    redirect_to quotation_path, status: :see_other # redirecionar para suas quotations
    authorize @quotation
  end

  private

  def quotations_params
    params.require(:quotation).permit(:size, :placement, :description, :date, photos: [])
  end

  def set_quotation
    @quotation = Quotation.find(params[:id])
  end
end
