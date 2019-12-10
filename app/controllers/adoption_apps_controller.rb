class AdoptionAppsController < ApplicationController 

  def index 
  end 
  
  def new 
    @faved_pets = cart.contents
  end 

  def create
    pets = Pet.find(params[:applied_pets])
    app = AdoptionApp.new(app_params)

    pets.each do |pet|
      app.pets << pet
    end

    if app.save
      flash[:notice] = "Your application is in" 
      pets.each do |pet|
        cart.remove_favorite(pet.id)
      end
      redirect_to "/cart"
    else
      flash[:notice] = "Please complete all required fields"
      @faved_pets = cart.contents
      render :new
    end
  end 

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end  
end 
