require 'rails_helper'

RSpec.describe "as a vistor" do 
  describe "when I visit a shelters show page" do 
    before(:each) do 
      @shelter_1 = Shelter.create!(
                      name: "Rescuers Up Over",
                      address: "246 Glenwood Dr",
                      city: "Boulder",
                      state: "CO",
                      zip: "80304")
      @review_1 = @shelter_1.reviews.create!(
                      title: "Love them doggies",
                      rating: 5,
                      content: "some content",
                      opt_pic: "https://i.imgur.com/B0D4iRk.jpg")
    end 

    it "should show reviews for that shelter each should have:
    1. title
    2. rating
    3. content
    4. <optional> picture" do
      visit "/shelters/#{@shelter_1.id}"

      within "#reviews-#{@review_1.id}" do
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@review_1.content)
        expect(page).to have_css("img[src*='#{@review_1.opt_pic}']")
      end
    end
  end
end 

