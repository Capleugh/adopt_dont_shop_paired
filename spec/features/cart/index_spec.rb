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

    xit "shows me a list of all my favorite pets with
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

      visit "/cart"
      within "#fav-#{@pet_1.id}" do
        expect(page).to have_css("img[src*='#{@pet_1.image}']")
        click_link "#{@pet_1.name}"
        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end

      visit "/cart"
      within "#fav-#{@pet_2.id}" do
        expect(page).to have_css("img[src*='#{@pet_2.image}']")
        click_link "#{@pet_2.name}"
        expect(current_path).to eq("/pets/#{@pet_2.id}")
      end
    end

    xit "has a link next to each pet to remove from faves index and when I click it it removes and decrements" do

      visit "/pets/#{@pet_1.id}"
      within("#pet-#{@pet_1.id}") do
        click_button 'Fave it'
      end

      visit "/pets/#{@pet_2.id}"
      within("#pet-#{@pet_2.id}") do
        click_button 'Fave it'
      end

      visit "/cart"
      within "#fav-#{@pet_1.id}" do
        expect(page).to have_button("Unfave it")
        click_button "Unfave it"
        expect(current_path).to eq("/cart")
      end

      visit "/cart"
      within "#fav-#{@pet_2.id}" do
        expect(page).to have_button("Unfave it")
        expect(page).not_to have_button("Fave it")
        click_button "Unfave it"
        expect(current_path).to eq("/cart")
      end

      expect(page).to have_content("Favorites: 0")
    end

    xit "when I have not added any pets to my favorites list I see text indicating I have no favorited indicating that I have no favorited pets" do
      visit "/cart"

      expect(page).to have_content("Favorites: 0")
      expect(page).to have_content("You have no faved pets.")
    end

    # ask about preferred test structure for poros
    xit "I see a link to remove all favorited pets and am redirected back to same page where I see no faved pets text and favorites indicator is 0" do
      visit "/pets/#{@pet_1.id}"
      within("#pet-#{@pet_1.id}") do
        click_button 'Fave it'
      end

      visit "/pets/#{@pet_2.id}"
      within("#pet-#{@pet_2.id}") do
        click_button 'Fave it'
      end

      visit "/cart"

      click_button "Remove all faves"

      expect(current_path).to eq("/cart")

      expect(page).to have_content("Favorites: 0")
      expect(page).to have_content("You have no faved pets.")
    end

    it "I see a list of all pets that have at leaset one application on them
        and their name is a link to their show page" do 

      #fav some pets and apply for them  
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
      
      #now that we have some faved pets - we should see them
      visit '/cart'

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
    end
  end
end
