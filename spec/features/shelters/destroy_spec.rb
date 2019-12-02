require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit the shelter show page" do
    it "I can click a link to delete a shelter and I will no longer see the shelter index page" do
      shelter_1 = Shelter.create!(name: "Forever Home Finder",
                                  address: "246 Glenwood Dr",
                                  city: "Santa Fe",
                                  state: "NM",
                                  zip: "80304")
      shelter_2 = Shelter.create!(name: "Denver Cat Company",
                                  address: "3929 Tennyson St",
                                  city: "Denver",
                                  state: "CO",
                                  zip: "80212")

        visit "/shelters/#{shelter_1.id}"

        click_button 'Delete'
        expect(current_path).to eq('/shelters')

        expect(page).to_not have_content(shelter_1.name)
        expect(page).to have_content(shelter_2.name)
    end

    it "can delete shelters with pets" do
      shelter_1 = Shelter.create!(name: "Forever Home Finder",
                                  address: "246 Glenwood Dr",
                                  city: "Santa Fe",
                                  state: "NM",
                                  zip: "80859")
      shelter_2 = Shelter.create!(name: "Denver Cat Company",
                                  address: "3929 Tennyson St",
                                  city: "Denver",
                                  state: "CO",
                                  zip: "80212")
      pet_1 = shelter_1.pets.create!(image: 'https://s3.amazonaws.com/playbarkrun/wp-content/uploads/2018/05/11154028/1920px-V%C3%A4stg%C3%B6taspets_hane_5_%C3%A5r.jpg',
                                     name: 'Larry',
                                     description: 'Sweet, pint-sized ball of fluff and love.',
                                     approximate_age: 5,
                                     sex: 'female',
                                     status: 'adoptable')

      visit "/shelters"

      first(:button, 'Delete').click
      expect(current_path).to eq("/shelters")

      expect(page).to_not have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end
  end
end
