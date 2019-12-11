class AdoptionAppsPetsController < ApplicationController
  def update
    #@app = AdoptionApp.find(params[:app_id])
    @pet = Pet.find(params[:pet_id])

    @display_pets = Pet.select(:name, :id).joins(:adoption_apps)

    #@pet.adoption_apps
    @pet.update!(status: "Pending")

    redirect_to "/pets/#{params[:pet_id]}" 

  end 
end 
