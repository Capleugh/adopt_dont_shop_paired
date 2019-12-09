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

      visit '/cart'

      click_link "Apply"

      expect(current_path).to eq("/adoption_apps/new")

      fill_in "name", with: "bob"  
      fill_in "address", with: "100 best lane"  
      fill_in "city", with: "denver"  
      fill_in "state", with: "co"  
      fill_in "zip", with: "80204"  
      fill_in "phone", with: "111-222-3333"  
      fill_in "description", with: "b/c I am really lonely...please send pets"  

      click_button "Submit application"
      expect(current_path).to eq("/adoption_apps")

      #new_app = AdoptionApp.last

      #expect(new_app).to have_content("bob")
      #expect(new_app).to have_content("100 best lane")
      #expect(new_app).to have_content("denver")
      #expect(new_app).to have_content("co")
      #expect(new_app).to have_content("80204")
      #expect(new_app).to have_content("111-222-3333")
      #expect(new_app).to have_content("b/c I am really lonely...please send pets")  

    end 
  end
end
