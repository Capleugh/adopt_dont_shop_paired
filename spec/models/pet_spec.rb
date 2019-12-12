require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :image}
    it { should validate_presence_of :name}
    it { should validate_presence_of :approximate_age}
    it { should validate_presence_of :sex}
  end

  describe "relationships" do
    it { should belong_to :shelter}
    it { should have_many :adoption_app_pets}
    it { should have_many(:adoption_apps).through(:adoption_app_pets)}
  end

  describe "instance methods" do
    it "applicant_name" do

    shelter_1 = Shelter.create!(name: "New Shelter",
                               address: "908 Beltline Dr",
                               city: "Richardson",
                               state: "TX",
                               zip: "75081")

    pet_1 = shelter_1.pets.create!(image: "https://s3.amazonaws.com/playbarkrun/wp-content/uploads/2018/05/11154028/1920px-v%c3%a4stg%c3%b6taspets_hane_5_%c3%a5r.jpg",
                                     name: 'larry',
                                     description: 'sweet, pint-sized ball of fluff and love.',
                                     approximate_age: 5,
                                     sex: 'female')
    pet_2 = shelter_1.pets.create!(image: 'https://i.pinimg.com/originals/f8/27/ed/f827ed9a704146f65b96226f430abf3c.png',
                                     name: 'Smudge',
                                     description: 'Very memeable. hates vegetals.',
                                     approximate_age: 3,
                                     sex: 'Male')
    app_1 = AdoptionApp.create!(name: "bob",
                                    address: "100 best lane",
                                    city: "denver",
                                    state: "co",
                                    zip: "80204",
                                    phone: "111-222-3333",
                                    description: "b/c I am really lonely...please send pets" )

    app_2 = AdoptionApp.create!(name: "phil",
                                    address: "100 best lane",
                                    city: "denver",
                                    state: "co",
                                    zip: "80204",
                                    phone: "111-222-3333",
                                    description: "b/c I am really lonely...please send pets" )
    app_1.pets << pet_1
    app_1.pets << pet_2
    app_2.pets << pet_1

    app_1.adoption_app_pets.first.update(status: "Pending")

    expect(pet_1.applicant_name.adoption_app.name).to eq("bob")
    end

  end
end
