class AdoptionAppsController < ApplicationController

  def new
    @faved_pets = cart.contents
  end

  def index 
    @names_applied_to_this_pet = AdoptionApp.select(:name, :id).joins(:pets).distinct

    if @names_applied_to_this_pet.empty? 
      @if_no_apps = "There are no current applications on this pet"
    end
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
    @app = AdoptionApp.find(params[:app_id])
    @display_pets = Pet.select(:name, :id).joins(:adoption_apps)
    # require "pry"; binding.pry
  end

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
