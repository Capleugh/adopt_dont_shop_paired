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
    # require "pry"; binding.pry
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    # MIKE why do we not have to call session[:cart] here?
    cart.remove_favorite(pet.id)
    flash[:notice] = "#{pet.name} has been unfaved from your favorites list!"

    # ask MIKE about why we dont need a pet "/pets/#{params[:pet_id]} redirect with the following method"
    redirect_back(fallback_location: "/cart")
    # needs refactor, this conditional is not explicit enough
    # if request.referrer.include?("cart") #== "#{request.env["HTTP_REFERER"]}/cart"request.referrer == request.env["HTTP_REFERER"]
    #   redirect_to "/cart"
    # else
    #   redirect_to "/pets/#{params[:pet_id]}"
    # end
  end

  def destroy_all
    #ask MIKE whether this is an acceptable action
    cart.remove_all
    session[:cart] = cart.contents
    # MIKE why does session[:cart] need to be updated for index to display correctly?

    redirect_to "/cart"
  end
end
