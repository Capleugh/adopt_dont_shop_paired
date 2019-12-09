class CartController < ApplicationController

  def index
    @view_faved = cart.all_favorites
    @no_faves = cart.empty?
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][pet_id_str] ||= 0
    session[:cart][pet_id_str] = pet

    flash[:notice] = "#{pet.name} has been faved to your favorites list!"

    redirect_to "/pets/#{params[:pet_id]}"
  end


  def destroy
    pet = Pet.find(params[:pet_id])
    cart.remove_favorite(pet.id)
    flash[:notice] = "#{pet.name} has been unfaved from your favorites list!"

    # ask mike/meg
    redirect_back(fallback_location: "/cart")
    # needs refactor, this conditional is not explicit enough
    # if request.referrer.include?("cart") #== "#{request.env["HTTP_REFERER"]}/cart"request.referrer == request.env["HTTP_REFERER"]
    #   redirect_to "/cart"
    # else
    #   redirect_to "/pets/#{params[:pet_id]}"
    # end
  end
end
