require "rails_helper"

RSpec.describe "as a visitor" do
  describe "when I visit the cart index page" do
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
      @app_1 = AdoptionApp.create!(name: "bob",
                                      address: "100 best lane",
                                      city: "denver",
                                      state: "co",
                                      zip: "80204",
                                      phone: "111-222-3333",
                                      description: "b/c I am really lonely...please send pets" )
      @app_2 = AdoptionApp.create!(name: "Sally",
                                      address: "2100 best lane",
                                      city: "suffux",
                                      state: "tx",
                                      zip: "22212",
                                      phone: "555-666-8888",
                                      description: "I am the best" )
    end
    it "I see a list of all pets that have at least one application on them
        and their name is a link to their show page" do

      #apply for some of those pets
      @app_1.pets << @pet_1
      @app_1.pets << @pet_2

      @app_2.pets << @pet_1
      @app_2.pets << @pet_2

      visit "/pets/#{@pet_1.id}"
      
      within("#pet-#{@pet_1.id}") do
        click_link "View all applications for this pet"
      end

      expect(page).to have_content(@app_1.name)
      expect(page).to have_content(@app_2.name)

      click_link "#{@app_1.name}"
      expect(current_path).to eq("/adoption_apps/#{@app_1.id}")

      visit "/pets/#{@pet_2.id}"
      within("#pet-#{@pet_2.id}") do
        click_link "View all applications for this pet"
      end

      expect(page).to have_content(@app_2.name)
      expect(page).to have_content(@app_2.name)

      click_link "#{@app_2.name}"
      expect(current_path).to eq("/adoption_apps/#{@app_2.id}")
    end

    it "shows me a message indicating that there are no applicaitons availalbe
        for a pet that does not have applications on them" do

      visit "/pets/#{@pet_1.id}/adoption_apps"

      within("#apply_pet") do
        expect(page).to have_content("There are no current applications on this pet")
      end
    end
  end
end
