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

  def edit
    @address = current_user.address
    authorize @address
  end

  def update
    @address = current_user.address
    @address.update(address_params)
    authorize @address
    redirect_to edit_user_registration_path
  end

  private

  def address_params
    params.require(:address).permit(:zipcode, :country, :city, :street, :number, :neighborhood, :state )
  end
end
