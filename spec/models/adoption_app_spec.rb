require "rails_helper"

RSpec.describe AdoptionApp do 
  describe "relationships" do 
    it { should have_many :adoption_app_pets }
  end 
end 
