class AdoptionAppsController < ApplicationController 

  def new 
    @faved_pets = cart.contents
  end 

  def create
    pets = Pet.find(params[:applied_pets])
    app = AdoptionApp.create!(app_params)
    pet_str_flsh = String.new

    pets.each do |pet|
      app.pets << pet
      cart.remove_favorite(pet.id)
    end

    flash[:notice] = "Your application is in" 
    

    redirect_to "/cart"
  end 

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end  
end 
