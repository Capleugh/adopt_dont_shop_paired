require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :image}
    it { should validate_presence_of :name}
    it { should validate_presence_of :approximate_age}
    it { should validate_presence_of :sex}
  end
  
  describe "relationships" do
    it { should belong_to :shelter}
    it { should have_many :adoption_app_pets}
    it { should have_many(:adoption_apps).through(:adoption_app_pets)}
  end
end
