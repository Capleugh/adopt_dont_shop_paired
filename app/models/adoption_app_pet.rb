class AdoptionAppPet < ApplicationRecord
  belongs_to :pet
  belongs_to :adoption_app

  def self.find_app(app, pet)
    # this represents ids in our routes
    self.where(pet_id: pet.id).where(adoption_app_id: app.id).take

    # google some stuff
  end
end
