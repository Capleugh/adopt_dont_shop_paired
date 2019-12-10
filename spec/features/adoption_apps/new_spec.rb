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
      @app_1.pets << @pet_1
      @app_1.pets << @pet_2
    end

    it "1. shows me a link for a adopting my favorited pets
        2. When I click said link, I am taken a new application form (cart/new)
        3. A) shows me favorited pets B) allows me to apply for those pets
        4. I select my pets and apply by filling in =Name =Address = City =State =Zip =Phone Number =Flowers about why I am the best pet parent
        5. I click the button to apply
        6. Flash message displays, indicating application was submitted
        7. redirected by to favorites page, see a list of my pets faved, minus the recently applied for" do

      visit "/pets/#{@pet_1.id}"
      within("#pet-#{@pet_1.id}") do
        click_button 'Fave it'
      end

      visit "/pets/#{@pet_2.id}"
      within("#pet-#{@pet_2.id}") do
        click_button 'Fave it'
      end

      visit "/pets/#{@pet_3.id}"
      within("#pet-#{@pet_3.id}") do
        click_button 'Fave it'
      end

      visit '/cart'

      click_link "Apply"

      expect(current_path).to eq("/adoption_apps/new")

      within "#app" do

        within "#pet-#{@pet_1.id}" do
          check("applied_pets_")
        end

        within "#pet-#{@pet_2.id}" do
          check("applied_pets_")
        end

        fill_in "name", with: "bob"
        fill_in "address", with: "100 best lane"
        fill_in "city", with: "denver"
        fill_in "state", with: "co"
        fill_in "zip", with: "80204"
        fill_in "phone", with: "111-222-3333"
        fill_in "description", with: "b/c I am really lonely...please send pets"
        click_button "Submit application"
      end

      expect(current_path).to eq("/cart")

      expect(page).to have_content("Your application is in")

      expect(page).not_to have_content(@pet_1.name)
      expect(page).not_to have_content(@pet_2.name)
      expect(page).to have_content(@pet_3.name)
    end

    it "User Story 17, Incomplete application for a Pet

    As a visitor
    When I apply for a pet and fail to fill out any of the following:
    - Name
    - Address
    - City
    - State
    - Zip
    - Phone Number
    - Description of why I'd make a good home for this/these pet(s)
    And I click on a button to submit my application
    I'm redirect back to the new application form to complete the necessary fields
    And I see a flash message indicating that I must complete the form in order to submit the application" do

      visit "/pets/#{@pet_1.id}"
      within("#pet-#{@pet_1.id}") do
        click_button 'Fave it'
      end

      visit "/pets/#{@pet_2.id}"
      within("#pet-#{@pet_2.id}") do
        click_button 'Fave it'
      end

      visit "/pets/#{@pet_3.id}"
      within("#pet-#{@pet_3.id}") do
        click_button 'Fave it'
      end

      visit '/cart'

      click_link "Apply"

      expect(current_path).to eq("/adoption_apps/new")

      within "#app" do

        within "#pet-#{@pet_1.id}" do
          check("applied_pets_")
        end

        within "#pet-#{@pet_2.id}" do
          check("applied_pets_")
        end

        fill_in "name", with: "rando"
        fill_in "address", with: ""
        fill_in "city", with: ""
        fill_in "state", with: "co"
        fill_in "zip", with: "80204"
        fill_in "phone", with: "111-222-3333"
        fill_in "description", with: "b/c I am really lonely...please send pets"
        click_button "Submit application"
      end

      expect(current_path).to eq("/adoption_apps")

      expect(page).to have_content("Please complete all required fields")
    end

    xit "handles edge case of no pets applied for" do

      visit "/pets/#{@pet_3.id}"
      within("#pet-#{@pet_3.id}") do
        click_button 'Fave it'
      end

      visit '/cart'

      click_link "Apply"

      fill_in "name", with: "bob"
      fill_in "address", with: "100 best lane"
      fill_in "city", with: "denver"
      fill_in "state", with: "co"
      fill_in "zip", with: "80204"
      fill_in "phone", with: "111-222-3333"
      fill_in "description", with: "b/c I am really lonely...please send pets"
      click_button "Submit application"

      expect(current_path).to eq("/adoption_apps")

      expect(page).to have_content("Please complete all required fields")
    end
  end
end
