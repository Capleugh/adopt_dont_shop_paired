require "rails_helper"

RSpec.describe "as a visitor" do
  describe "when I visit my favorites index page and have already previously favoritied some pets" do
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

    it "shows me a list of all my favorite pets with
    -pets name
    -pets image" do

      visit "/pets/#{@pet_1.id}"
      within("#pet-#{@pet_1.id}") do
        click_button 'Fave it'
      end

      visit "/pets/#{@pet_2.id}"
      within("#pet-#{@pet_2.id}") do
        click_button 'Fave it'
      end

      visit "/favorites"
      within "#fav-#{@pet_1.id}" do
        expect(page).to have_css("img[src*='#{@pet_1.image}']")
        click_link "#{@pet_1.name}"
        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end

      visit "/favorites"
      within "#fav-#{@pet_2.id}" do
        expect(page).to have_css("img[src*='#{@pet_2.image}']")
        click_link "#{@pet_2.name}"
        expect(current_path).to eq("/pets/#{@pet_2.id}")
      end
      
    end
  end
end
