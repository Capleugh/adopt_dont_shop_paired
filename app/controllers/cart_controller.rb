class CartController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][pet_id_str] ||= 0
    session[:cart][pet_id_str] = pet

    flash[:notice] = "#{pet.name} has been faved to your favorites list!"

    redirect_to "/pets/#{params[:pet_id]}"
  end

  def index
    @view_faved = cart.all_favorites
    @no_faves = cart.empty?
    @display_applied = Pet.select(:name, :id).joins(:adoption_apps)
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    cart.remove_favorite(pet.id)
    flash[:notice] = "#{pet.name} has been unfaved from your favorites list!"

    redirect_back(fallback_location: "/cart")
    # this could have been moved to the update method
  end

  def destroy_all
    cart.remove_all
    session[:cart] = cart.contents

    redirect_to "/cart"
  end
end
