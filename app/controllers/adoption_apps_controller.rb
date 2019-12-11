class AdoptionAppsController < ApplicationController

  def new
    @faved_pets = cart.contents
  end

  def index 
    # AdoptionApp.find(:name, :id).joins(:)
    # Pet.find(params[:pet_id]).adoption_apps
    # Pet.select(:name).joins(:adoption_apps)
    @names_applied_to_this_pet = AdoptionApp.select(:name, :id).joins(:pets).distinct
    
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

  def show
    # require "pry"; binding.pry
    @app = AdoptionApp.find(params[:app_id])
    @display_pets = Pet.select(:name, :id).joins(:adoption_apps)
    # require "pry"; binding.pry
  end

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
