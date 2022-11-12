class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user = current_user
    if @address.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  private

  def address_params
    params.require(:address).permit(:zipcode, :country, :city, :street, :number)
  end
end
