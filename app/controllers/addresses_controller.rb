class AddressesController < ApplicationController
  def new
    @address = Address.new
    authorize @address
  end

  def create
    @address = Address.new(address_params)
    @address.user = current_user
    if @address.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
    authorize @address
  end

  def update
    if @address.update(address_params)
      redirect_to root_path # redirecionar para pagina de perfil do usuário(artista)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @address
  end

  private

  def address_params
    params.require(:address).permit(:zipcode, :country, :city, :street, :number)
  end
end
