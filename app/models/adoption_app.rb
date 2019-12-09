class AdoptionApp < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone, :description

  has_many :adoption_app_pets
  has_many :pets, through: :adoption_app_pets
end
