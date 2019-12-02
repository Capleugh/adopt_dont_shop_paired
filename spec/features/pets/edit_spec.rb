require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I vist the pets show page" do
    it "when I click the link to edit pet, I am taken to a form to edit pet's data including image, name, description, age, and sex" do
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
      visit "/pets/#{pet_1.id}"

      click_link 'Update'
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      name = 'Robert'
      description = 'Corgsky? Huskorgi?'
      approximate_age = 2
      sex = 'male'

      fill_in 'image', with: 'https://www.smartpettoysreview.com/content/images/2019/05/dog-corgi-husky-mix.jpg'
      fill_in 'name', with: name
      fill_in 'description', with: description
      fill_in 'approximate_age', with: approximate_age
      fill_in 'sex', with: sex

      click_button 'Submit'
      expect(current_path).to eq("/pets/#{pet_1.id}")

      expect(page).to have_css("img[src *= 'https://www.smartpettoysreview.com/content/images/2019/05/dog-corgi-husky-mix.jpg']")
      expect(page).to have_content(name)
      expect(page).to have_content(description)
      expect(page).to have_content(approximate_age)
      expect(page).to have_content(sex)

      expect(page).to_not have_css("img[src *='https://s3.amazonaws.com/playbarkrun/wp-content/uploads/2018/05/11154028/1920px-V%C3%A4stg%C3%B6taspets_hane_5_%C3%A5r.jpg']")
      expect(page).to_not have_content('Larry')
      expect(page).to_not have_content('Sweet, pint-sized ball of fluff and love.')
      expect(page).to_not have_content(5)
      expect(page).to_not have_content('female')
    end

    it "when I visit the pet index page I see a link next to each pet to update their information" do
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

      first(:link, 'Update').click
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      name = 'Robert'
      description = 'Corgsky? Huskorgi?'
      approximate_age = 2
      sex = 'male'

      fill_in 'image', with: 'https://www.smartpettoysreview.com/content/images/2019/05/dog-corgi-husky-mix.jpg'
      fill_in 'name', with: name
      fill_in 'description', with: description
      fill_in 'approximate_age', with: approximate_age
      fill_in 'sex', with: sex

      click_button 'Submit'
      expect(current_path).to eq("/pets/#{pet_1.id}")

      expect(page).to have_css("img[src *= 'https://www.smartpettoysreview.com/content/images/2019/05/dog-corgi-husky-mix.jpg']")
      expect(page).to have_content(name)
      expect(page).to have_content(description)
      expect(page).to have_content(approximate_age)
      expect(page).to have_content(sex)

      expect(page).to_not have_css("img[src *='https://s3.amazonaws.com/playbarkrun/wp-content/uploads/2018/05/11154028/1920px-V%C3%A4stg%C3%B6taspets_hane_5_%C3%A5r.jpg']")
      expect(page).to_not have_content('Larry')
      expect(page).to_not have_content('Sweet, pint-sized ball of fluff and love.')
      expect(page).to_not have_content(5)
      expect(page).to_not have_content('female')
    end

    it "when I visit the shelter pets index page I see a link next to each pet to update their information" do
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

      first(:link, 'Update').click
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/#{pet_1.id}/edit")
# save_and_open_page
      name = 'Robert'
      description = 'Corgsky? Huskorgi?'
      approximate_age = 2
      sex = 'male'

      fill_in 'image', with: 'https://www.smartpettoysreview.com/content/images/2019/05/dog-corgi-husky-mix.jpg'
      fill_in 'name', with: name
      fill_in 'description', with: description
      fill_in 'approximate_age', with: approximate_age
      fill_in 'sex', with: sex

      click_button 'Submit'
      expect(current_path).to eq("/pets/#{pet_1.id}")

      expect(page).to have_css("img[src*='https://www.smartpettoysreview.com/content/images/2019/05/dog-corgi-husky-mix.jpg']")
      expect(page).to have_content(name)
      expect(page).to have_content(description)
      expect(page).to have_content(approximate_age)
      expect(page).to have_content(sex)

      expect(page).to_not have_css("img[src*='https://s3.amazonaws.com/playbarkrun/wp-content/uploads/2018/05/11154028/1920px-V%C3%A4stg%C3%B6taspets_hane_5_%C3%A5r.jpg']")
      expect(page).to_not have_content('Larry')
      expect(page).to_not have_content('Sweet, pint-sized ball of fluff and love.')
      expect(page).to_not have_content(5)
      expect(page).to_not have_content('female')
    end
  end
end
