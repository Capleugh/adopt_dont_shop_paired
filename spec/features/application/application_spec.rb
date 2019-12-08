require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I click on the fave indicator in nav bar" do
    it "I am taken to the favorites index page" do

      visit '/shelters'

      click_link 'Favorites'

      expect(current_path).to eq('/cart')
    end
  end

  describe "when I click on the fave indicator in nav bar" do
    it "I am taken to the favorites index page" do

      visit '/pets'

      click_link 'Favorites'

      expect(current_path).to eq('/cart')
    end
  end
end
