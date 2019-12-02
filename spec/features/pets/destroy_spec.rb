require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit the pets show page" do
    it "and I click the delete button, I am redirected to the pet index page where I no longer see this pet" do
      shelter_1 = Shelter.create!(name: "New Shelter",
                                  address: "908 Beltline Dr",
                                  city: "Richardson",
                                  state: "TX",
                                  zip: "75081")
      pet_1 = shelter_1.pets.create!(image: 'https://s3.amazonaws.com/playbarkrun/wp-content/uploads/2018/05/11154028/1920px-V%C3%A4stg%C3%B6taspets_hane_5_%C3%A5r.jpg',
                                     name: 'Larry',
                                     description: 'Sweet, pint-sized ball of fluff and love.',
                                     approximate_age: 5,
                                     sex: 'female',
                                     status: 'adoptable')
      pet_2 = shelter_1.pets.create!(image: 'https://i.pinimg.com/originals/03/fe/7d/03fe7d86bcba1c66fa369c3188780e04.jpg',
                                     name: 'Bartok',
                                     description: "This bat-eared, yoda cat definitely won't destroy everything in your home.",
                                     approximate_age: 1,
                                     sex: 'male',
                                     status: 'pending adoption')

        visit "/pets/#{pet_1.id}"

        click_button 'Delete'
        expect(current_path).to eq("/pets")

        expect(page).to_not have_css("img[src*='#{pet_1.image}']")
        expect(page).to_not have_content(pet_1.name)
        expect(page).to_not have_content(pet_1.description)
        expect(page).to_not have_content(pet_1.approximate_age)
        expect(page).to_not have_content(pet_1.sex)
        expect(page).to_not have_content(pet_1.status)
        expect(page).to have_content(pet_1.shelter.name)

        expect(page).to have_css("img[src*='#{pet_2.image}']")
        expect(page).to have_content(pet_2.name)
        expect(page).to have_content(pet_2.approximate_age)
        expect(page).to have_content(pet_2.sex)
        expect(page).to_not have_content(pet_2.status)
        expect(page).to have_content(pet_2.shelter.name)
    end

    it "when I visit the pets index page I see a delete button next to each pet" do
      shelter_1 = Shelter.create!(name: "New Shelter",
                                  address: "908 Beltline Dr",
                                  city: "Richardson",
                                  state: "TX",
                                  zip: "75081")
      pet_1 = shelter_1.pets.create!(image: 'https://s3.amazonaws.com/playbarkrun/wp-content/uploads/2018/05/11154028/1920px-V%C3%A4stg%C3%B6taspets_hane_5_%C3%A5r.jpg',
                                     name: 'Larry',
                                     description: 'Sweet, pint-sized ball of fluff and love.',
                                     approximate_age: 5,
                                     sex: 'female',
                                     status: 'adoptable')
      pet_2 = shelter_1.pets.create!(image: 'https://i.pinimg.com/originals/03/fe/7d/03fe7d86bcba1c66fa369c3188780e04.jpg',
                                     name: 'Bartok',
                                     description: "This bat-eared, yoda cat definitely won't destroy everything in your home.",
                                     approximate_age: 1,
                                     sex: 'male',
                                     status: 'pending adoption')
      visit "/pets"

      first(:button, 'Delete').click
      expect(current_path).to eq("/pets")

      expect(page).to_not have_css("img[src*='#{pet_1.image}']")
      expect(page).to_not have_content(pet_1.name)
      expect(page).to_not have_content(pet_1.description)
      expect(page).to_not have_content(pet_1.approximate_age)
      expect(page).to_not have_content(pet_1.sex)
      expect(page).to_not have_content(pet_1.status)
      expect(page).to have_content(pet_1.shelter.name)

      expect(page).to have_css("img[src*='#{pet_2.image}']")
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.approximate_age)
      expect(page).to have_content(pet_2.sex)
      expect(page).to_not have_content(pet_2.status)
      expect(page).to have_content(pet_2.shelter.name)
    end

    it "when I visit the shelter pets index page I see a delete button next to each pet" do
      shelter_1 = Shelter.create!(name: "New Shelter",
                                  address: "908 Beltline Dr",
                                  city: "Richardson",
                                  state: "TX",
                                  zip: "75081")
      pet_1 = shelter_1.pets.create!(image: 'https://s3.amazonaws.com/playbarkrun/wp-content/uploads/2018/05/11154028/1920px-V%C3%A4stg%C3%B6taspets_hane_5_%C3%A5r.jpg',
                                     name: 'Larry',
                                     description: 'Sweet, pint-sized ball of fluff and love.',
                                     approximate_age: 5,
                                     sex: 'female',
                                     status: 'adoptable')
      pet_2 = shelter_1.pets.create!(image: 'https://i.pinimg.com/originals/03/fe/7d/03fe7d86bcba1c66fa369c3188780e04.jpg',
                                     name: 'Bartok',
                                     description: "This bat-eared, yoda cat definitely won't destroy everything in your home.",
                                     approximate_age: 1,
                                     sex: 'male',
                                     status: 'pending adoption')
      visit "/shelters/#{shelter_1.id}/pets"

      first(:button, 'Delete').click
      expect(current_path).to eq("/pets")

      expect(page).to_not have_css("img[src*='#{pet_1.image}']")
      expect(page).to_not have_content(pet_1.name)
      expect(page).to_not have_content(pet_1.description)
      expect(page).to_not have_content(pet_1.approximate_age)
      expect(page).to_not have_content(pet_1.sex)
      expect(page).to_not have_content(pet_1.status)
      expect(page).to have_content(pet_1.shelter.name)

      expect(page).to have_css("img[src*='#{pet_2.image}']")
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.approximate_age)
      expect(page).to have_content(pet_2.sex)
      expect(page).to_not have_content(pet_2.status)
      expect(page).to have_content(pet_2.shelter.name)
    end
  end
end
