class Pet < ApplicationRecord
  belongs_to :shelter
  validates_presence_of :image, :name, :approximate_age, :sex
  
  has_many :adoption_app_pets
  has_many :adoption_apps, through: :adoption_app_pets 

  def applicant_name
    binding.pry
    adoption_app_pets.find_by(status: "approved").adoption_app.name
  end
end

