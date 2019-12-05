require 'rails_helper'

RSpec.describe "As a visitior" do
  describe "when I visit shelter's show page" do
    before(:each) do
      @shelter_1 = Shelter.create!(
                      name: "Rescuers Up Over",
                      address: "246 Glenwood Dr",
                      city: "Boulder",
                      state: "CO",
                      zip: "80304")                         
    end

    it "when I click the link to creat a new review, I see a form which has title, rating, content, and optional image field that redirects to shelter's show page where review is displayed" do

      visit "/shelters/#{@shelter_1.id}"

      click_link 'Add Review'
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")


      fill_in 'title', with: 'Love them doggies'
      fill_in 'rating', with: 5
      fill_in 'content', with: 'some content'
      fill_in 'opt_pic', with: 'https://i.imgur.com/B0D4iRk.jpg'
      click_on 'Submit'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to have_content('Love them doggies')
      expect(page).to have_content(5)
      expect(page).to have_content('some content')
      expect(page).to have_css("img[src *= 'https://i.imgur.com/B0D4iRk.jpg']")
    end

    it "when I fail to enter title, rating, or content and submits a new review:
      1. Flash message indicating they need to fill these fields
      2. returned to new form to complete correctly" do

      visit "/shelters/#{@shelter_1.id}/reviews/new"

      click_on 'Submit'

      expect(page).to have_content('Review not created - Please complete required fields')
      expect(page).to have_button("Submit")
    end
  end
end
