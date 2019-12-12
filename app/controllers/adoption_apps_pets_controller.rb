class AdoptionAppsPetsController < ApplicationController
  def update
    @app = AdoptionApp.find(params[:app_id])
    @pet = Pet.find(params[:pet_id])

    @pet.adoption_apps
    @pet.update!(status: "Pending")
    AdoptionAppPet.find_app(@app, @pet).update!(status: "Pending")
    redirect_to "/pets/#{params[:pet_id]}"
 # make sure you understand this stuff (you wanna call this because you wanna update your joins table too)
  end
end
