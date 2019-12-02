require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the shelter index page" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Forever Home Finder",
                                 address: "246 Glenwood Dr",
                                 city: "Santa Fe",
                                 state: "NM",
                                 zip: "80859")
      @shelter_2 = Shelter.create(name: "Rescuers Up Over",
                                 address: "905 Manhattan Dr",
                                 city: "Boulder",
                                 state: "CO",
                                 zip: "80303")

      visit "/shelters"
    end

    it "I can see the name of all shelters" do

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
    end

    it "I can see links to edit each shelter and clicking that first link redirects me to the edit form" do

      first(:link, 'Edit').click
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

      fill_in 'Name', with: 'Furever Home Finder'
      fill_in 'Address', with: '248 Grove Rd'
      fill_in 'City', with: 'Dallas'
      fill_in 'State', with: 'TX'
      fill_in 'Zip', with: '75243'
      click_on 'Update Shelter'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content('Furever Home Finder')
      expect(page).to have_content('248 Grove Rd')
      expect(page).to have_content('Dallas')
      expect(page).to have_content('TX')
      expect(page).to have_content('75243')

      expect(page).to_not have_content('Forever Home Finder')
      expect(page).to_not have_content('246 Glenwood Dr')
      expect(page).to_not have_content('Santa Fe')
      expect(page).to_not have_content('NM')
      expect(page).to_not have_content('80859')
    end

    it "when I click on the name of a shelter, I am taken to that shelter's show page" do

      click_link "#{@shelter_1.name}"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    end

    it "I can click a pet index link which takes me to the pet index" do
      click_link 'Pet Index'
      expect(current_path).to eq("/pets")
    end

    it "I can click a shelter index link which takes me to the shelter index" do
      click_link 'Shelter Index'
      expect(current_path).to eq("/shelters")
    end
  end
end
