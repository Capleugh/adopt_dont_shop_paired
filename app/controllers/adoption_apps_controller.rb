class AdoptionAppsController < ApplicationController 

  def new 
    @faved_pets = cart.contents
  end 

  def create
    pets = Pet.find(params[:applied_pets])
    app = AdoptionApp.create!(app_params)

    pets.each do |pet|
      app.pets << pet
    end

    binding.pry
    flash[:notice] = "your application for #{}"
    redirect_to "/cart"
  end 

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end  
end 
