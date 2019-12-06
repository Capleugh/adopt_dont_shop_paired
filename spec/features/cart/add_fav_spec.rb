require "rails_helper"

RSpec.describe "as a visitor" do
  describe "I see a favorite indicator in the navigation bar && on every page this is shown" do
    before(:each) do
      @shelter_1 = Shelter.create!(name: "New Shelter",
                                 address: "908 Beltline Dr",
                                 city: "Richardson",
                                 state: "TX",
                                 zip: "75081")

      @pet_1 = @shelter_1.pets.create!(image: "https://s3.amazonaws.com/playbarkrun/wp-content/uploads/2018/05/11154028/1920px-v%c3%a4stg%c3%b6taspets_hane_5_%c3%a5r.jpg",
                                       name: 'larry',
                                       description: 'sweet, pint-sized ball of fluff and love.',
                                       approximate_age: 5,
                                       sex: 'female',
                                       status: 'adoptable')
      @pet_2 = @shelter_1.pets.create!(image: 'https://i.pinimg.com/originals/f8/27/ed/f827ed9a704146f65b96226f430abf3c.png',
                                       name: 'smudge',
                                       description: 'very memeable. hates vegetals.',
                                       approximate_age: 3,
                                       sex: 'male',
                                       status: 'pending adoption')
    end

    it "I see a count of pets in my favorites list" do

      visit "/pets"

      within("#fav") do
        expect(page).to have_content("Favorites: 1")
      end
    end

    it "When I click the button to favorite a pet I am taken to that pet's show page and I see a message that confirms pet was added to favorites" do

      visit "/pets/#{@pet_1.id}"

      within("#pet-#{@pet_1.id}") do
        click_button 'Fave it'
      end

      expect(current_path).to eq("/pets/#{@pet_1.id}")
      expect(page).to have_content("#{@pet_1.name} has been faved to your favorites list!")
      expect(page).to have_content("Favorites: 2")
    end

    xit "I see the favorite indicator increment by 1" do

    end
  end
end
