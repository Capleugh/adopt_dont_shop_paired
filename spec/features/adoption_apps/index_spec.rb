require "rails_helper"

RSpec.describe "as a visitor" do 
  describe "when I visit the cart index page" do 
    it "I see a list of all pets that have at leaset one application on them
        and their name is a link to their show page" do 

      visit '/cart'

      expect(page).to eq("dog")
    end
  end 
end 
