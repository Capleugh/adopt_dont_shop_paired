class PetsController < ApplicationController
  def index
    if params[:shelter_id]
      @shelter = Shelter.find(params[:shelter_id])
      @pets = @shelter.pets
    else
      @pets = Pet.all
    end
  end

  def show
    if params[:pet_id] != nil
      @pet = Pet.find(params[:pet_id])
    else
      @pet = Pet.find(params[:id])
    end

    if params[:app_id] != nil
      @pet.update!(status: "Pending")
    end

    @pet_app = AdoptionApp.select(:id, :name).joins(:pets).distinct.last

    # we probably need an active record query to link these things but really think about it.
    # @cart = Cart.new(session[:cart])
    # do we need to access cart here or was that a mistake?
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter.pets.create!(pet_params)

    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update!(pet_params)

    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    pet.destroy

    redirect_to "/pets"
  end

  private
    def pet_params
      params.permit(:image, :name, :description, :approximate_age, :sex)
    end
end
