class FavoritesController < ApplicationController
  def index
    # if session[:cart] != nil
    #   faved_pets = session[:cart].keys
    # else
    #   faved_pets = Hash.new(0)
    # end

    @view_faved = cart.all_favorites
  end
end
