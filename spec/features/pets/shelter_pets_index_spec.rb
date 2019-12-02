require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit the shelter pets index page" do
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
      @pet_1 = @shelter_1.pets.create!(image: 'https://s3.amazonaws.com/playbarkrun/wp-content/uploads/2018/05/11154028/1920px-V%C3%A4stg%C3%B6taspets_hane_5_%C3%A5r.jpg',
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
      @pet_3 = @shelter_1.pets.create!(image: 'https://i.pinimg.com/originals/03/fe/7d/03fe7d86bcba1c66fa369c3188780e04.jpg',
                                      name: 'Bartok',
                                      description: "This bat-eared, yoda cat definitely won't destroy everything in your home.",
                                      approximate_age: 1,
                                      sex: 'male',
                                      status: 'pending adoption')

      visit "/shelters/#{@shelter_1.id}/pets"
    end

    it "I see a list of all pets that can be adopted from that shelter with that shelter_id" do
      expect(page).to have_css("img[src*='#{@pet_1.image}']")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.approximate_age)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to have_content(@pet_1.shelter.name)


      expect(page).to have_css("img[src*='#{@pet_3.image}']")
      expect(page).to have_content(@pet_3.name)
      expect(page).to have_content(@pet_3.approximate_age)
      expect(page).to have_content(@pet_3.sex)
      expect(page).to have_content(@pet_3.shelter.name)


      expect(page).to_not have_css("img[src*='#{@pet_2.image}']")
      expect(page).to_not have_content(@pet_2.name)
      expect(page).to_not have_content(@pet_2.approximate_age)

      expect(page).to_not have_content(@pet_2.shelter.name)
    end

    it "when I click on the name of a shelter, I am taken to that shelter's show page" do

      click_link "#{@shelter_1.name}"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    end

    it "when I click on the name of a pet, I am taken to that pet's show page" do

      click_link "#{@pet_1.name}"
      expect(current_path).to eq("/pets/#{@pet_1.id}")
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
