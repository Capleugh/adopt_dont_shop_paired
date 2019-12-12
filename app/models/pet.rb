class Pet < ApplicationRecord
  belongs_to :shelter
  validates_presence_of :image, :name, :approximate_age, :sex

  has_many :adoption_app_pets
  has_many :adoption_apps, through: :adoption_app_pets

  def applicant_name
    AdoptionAppPet.find_by(status: "Pending")
  end
end
