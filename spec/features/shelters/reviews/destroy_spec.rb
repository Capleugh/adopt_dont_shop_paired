require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a shelter's show page" do
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
      @review_2 = @shelter_1.reviews.create!(
                      title: "WOW...",
                      rating: 1,
                      content: "This is the WORST shelter I have ever been to. The staff took 30 whole seconds to acknowledge me when I walked through the door, even though they were helping other folks. You just lost a customer.",
                      opt_pic: "")
      end

      it "next to each review, I will see a button to delete that review" do
        visit "/shelters/#{@shelter_1.id}"

        within "#reviews-#{@review_1.id}" do
          expect(page).to have_button('Delete Review')

          click_button 'Delete Review'
          # save_and_open_page
        end

        expect(current_path).to eq("/shelters/#{@shelter_1.id}")
        expect(page).to_not have_content(@review_1.title)
        expect(page).to_not have_content(@review_1.rating)
        expect(page).to_not have_content(@review_1.content)
        expect(page).to_not have_css("img[src*='#{@review_1.opt_pic}']")

        expect(page).to have_content(@review_2.title)
        expect(page).to have_content(@review_2.rating)
        expect(page).to have_content(@review_2.content)
      end
    end
  end


  #     it "When I click that button, I am redirected to the shelter's show page where I no longer see that review" do
  #       expect(current_path).to eq("/shelter_1.id/#{@shelter_1.id}")
  #       expect(page).to_not have_content(@review_1.title)
  #       expect(page).to_not have_content(@review_1.rating)
  #       expect(page).to_not have_content(@review_1.content)
  #       expect(page).to_not have_css("img[src*='#{@review_1.opt_pic}']")
  #
  #       expect(page).to have_content(@review_2.title)
  #       expect(page).to have_content(@review_2.rating)
  #       expect(page).to have_content(@review_2.content
  #   end
  # end
