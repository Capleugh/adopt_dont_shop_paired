require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit an applications show page" do
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
      @pet_3 = @shelter_1.pets.create!(image: 'https://i.pinimg.com/originals/03/fe/7d/03fe7d86bcba1c66fa369c3188780e04.jpg',
                                      name: 'Bartok',
                                      description: "This bat-eared, yoda cat definitely won't destroy everything in your home.",
                                      approximate_age: 2,
                                      sex: 'male',
                                      status: 'pending adoption')
      @app_1 = AdoptionApp.create!(name: "Boberino ",
                                      address: "100 best lane",
                                      city: "denver",
                                      state: "co",
                                      zip: "80204",
                                      phone: "111-222-3333",
                                      description: "b/c I am really lonely...please send pets" )
      @app_1.pets << @pet_1
      @app_1.pets << @pet_2
    end

    xit "I can see the application's info including name, address, city, state, zip, phone, description, and all pets included in app" do

      visit "/adoption_apps/#{@app_1.id}"

      within "#app-#{@app_1.id}" do
        expect(page).to have_content(@app_1.name)
        expect(page).to have_content(@app_1.address)
        expect(page).to have_content(@app_1.city)
        expect(page).to have_content(@app_1.state)
        expect(page).to have_content(@app_1.zip)
        expect(page).to have_content(@app_1.phone)
        expect(page).to have_content(@app_1.description)
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_2.name)
      end
    end

    it "when I click the approve link which should appear next to each pet on app, I amm taken to that pet's show page where I see that adoptable status has changed to pending" do
      visit "/adoption_apps/#{@app_1.id}"

      within("#pet-#{@pet_1.id}") do
        click_link 'Approve'
      end


      expect(current_path).to eq("/pets/#{@pet_1.id}")

      expect(page).to have_content("Pending")
      expect(page).to_not have_content("Adoptable")
      expect(page).to have_content("On hold for Boberino")

      visit "/adoption_apps/#{@app_1.id}"

      within("#pet-#{@pet_2.id}") do
        click_link 'Approve'
      end

      expect(current_path).to eq("/pets/#{@pet_2.id}")

      expect(page).to have_content("Pending")
      expect(page).to_not have_content("Adoptable")
      expect(page).to have_content("On hold for Boberino")
    end

  end
end
