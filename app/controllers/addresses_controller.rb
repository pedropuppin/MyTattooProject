class AddressesController < ApplicationController
  def new
    @address = Address.new
    authorize @address
  end

  def create
    @address = Address.new(address_params)
    @address.user = current_user
    if @address.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
    authorize @address
  end

  def edit
    @address = Address.find(params[:id])
    authorize @address
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    authorize @address
    if @address.save
      redirect_to user_profile_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:address).permit(:zipcode, :country, :city, :street, :number, :neighborhood, :state)
  end
end
