class FavoritesController < ApplicationController
  def index
    faved_pets = session[:cart].keys 
    #can this be refactored to be more MVC ish/restful 
    @view_faved_pets = faved_pets.map do |faved_pet|
      pet_object = Pet.find(faved_pet)
    end
  end 
end 
