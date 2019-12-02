require 'rails_helper'

RSpec.describe "Edit shelter" do
  describe "as a visitor" do
    describe "when I click the link to edit shelter" do
      it "I am taken to a form to edit shelter's data" do
        shelter_1 = Shelter.create(name: "Forever Home Finder",
                                   address: "246 Glenwood Dr",
                                   city: "Boulder",
                                   state: "CO",
                                   zip: "80304")

        visit "/shelters/#{shelter_1.id}"
        click_link 'Edit'

        expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

        fill_in 'Name', with: 'Furever Home Finder'
        fill_in 'Address', with: '248 Grove Rd'
        fill_in 'City', with: 'Dallas'
        fill_in 'State', with: 'TX'
        fill_in 'Zip', with: '75243'
        click_on 'Update Shelter'

        expect(current_path).to eq("/shelters/#{shelter_1.id}")
        expect(page).to have_content('Furever Home Finder')
        expect(page).to have_content('248 Grove Rd')
        expect(page).to have_content('Dallas')
        expect(page).to have_content('TX')
        expect(page).to have_content('75243')
        expect(page).to_not have_content('Forever Home Finder')
        expect(page).to_not have_content('246 Glenwood Dr')
        expect(page).to_not have_content('Boulder')
        expect(page).to_not have_content('CO')
        expect(page).to_not have_content('80304')
      end
    end
  end
end
