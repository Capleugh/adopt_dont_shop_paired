require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a shelter's show page" do
    before(:each) do
      @shelter_1 = Shelter.create(
                      name: "Rescuers Up Over",
                      address: "246 Glenwood Dr",
                      city: "Boulder",
                      state: "CO",
                      zip: "80304")
      @review_1 = @shelter_1.reviews.create(
                      title: "Love them doggies",
                      rating: 5,
                      content: "some content",
                      opt_pic: "https://i.imgur.com/B0D4iRk.jpg")
    end

    it "when I click on the link to edit shelter review I am taken to edit screen for that review with prepopulated fields of
    - title
    - rating
    - content
    - image
    which I can then modify, submit, and see updated review on shelter's show page" do

      visit "/shelters/#{@shelter_1.id}"

      click_link "Edit Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit")

      expect(find_field('title').value).to eq "Love them doggies"
      expect(find_field('rating').value).to eq "5"
      expect(find_field('content').value).to eq "some content"

      fill_in 'title', with: 'Really weird vibes'
      select "1", from: :rating
      fill_in 'content', with: 'Terrible flourescent lighting. Not great for insta, tbh. Selection subpar. No purebreds'
      fill_in 'opt_pic', with: 'https://i.imgur.com/hl4dONR.jpg'

      click_on 'Update Review'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content('Really weird vibes')
      expect(page).to have_content(1)
      expect(page).to have_content('Terrible flourescent lighting. Not great for insta, tbh. Selection subpar. No purebreds')
      expect(page).to have_css("img[src*='https://i.imgur.com/hl4dONR.jpg']")
    end

    it "requires the user to input a rating, content, and description and provides a flash message if the user does not and directs them back to the edit page to reentry" do

      visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

      fill_in 'title', with: ""
      fill_in 'content', with: ""
      select "5", from: :rating

      click_on 'Update Review'

      expect(page).to have_content("Please enter a Title, Rating, and Content")
      expect(page).to have_button("Update Review")
    end
  end
end
