require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit the pets index page" do
    before(:each) do
      @shelter_1 = Shelter.create!(name: "New Shelter",
                                 address: "908 Beltline Dr",
                                 city: "Richardson",
                                 state: "TX",
                                 zip: "75081")
      @shelter_2 = Shelter.create!(name: "Denver Cat Company",
                                 address: "3929 Tennyson St",
                                 city: "Denver",
                                 state: "CO",
                                 zip: "80212")
      @pet_1 = @shelter_1.pets.create!(image: "https://s3.amazonaws.com/playbarkrun/wp-content/uploads/2018/05/11154028/1920px-V%C3%A4stg%C3%B6taspets_hane_5_%C3%A5r.jpg",
                                       name: 'Larry',
                                       description: 'Sweet, pint-sized ball of fluff and love.',
                                       approximate_age: 5,
                                       sex: 'female',
                                       status: 'adoptable')
      @pet_2 = @shelter_2.pets.create!(image: 'https://i.pinimg.com/originals/f8/27/ed/f827ed9a704146f65b96226f430abf3c.png',
                                       name: 'Smudge',
                                       description: 'Very memeable. Hates vegetals.',
                                       approximate_age: 3,
                                       sex: 'male',
                                       status: 'pending adoption')

      visit '/pets'
    end

    it "I see each pet in the system and all of their info" do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.approximate_age)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to have_content(@pet_1.shelter.name)
      expect(page).to have_css("img[src*='#{@pet_1.image}']")

      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.approximate_age)
      expect(page).to have_content(@pet_2.sex)
      expect(page).to have_content(@pet_2.shelter.name)
      expect(page).to have_css("img[src*='#{@pet_2.image}']")
    end

    it "when I click on the name of a shelter, I am taken to that shelter's show page" do
      click_link "#{@pet_1.shelter.name}"
      expect(current_path).to eq("/shelters/#{@pet_1.shelter.id}")
    end

    it "when I click on the name of a pet, I am taken to that pet's show page" do
      click_link "#{@pet_1.name}"
      expect(current_path).to eq("/pets/#{@pet_1.id}")
    end

    it "when I visit the pets index page, I can click a pet index link which takes me to the pet index" do
      click_link 'Pet Index'
      expect(current_path).to eq("/pets")
    end

    it "when I visit the pets index page, I can click a shelter index link which takes me to the shelter index" do
      click_link 'Shelter Index'
      expect(current_path).to eq("/shelters")
    end
  end
end
