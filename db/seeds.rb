# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.destroy_all
Pet.destroy_all

shelter_1 = Shelter.create(name: "Rescuers Up Over",
               address: "246 Glenwood Dr",
               city: "Boulder",
               state: "CO",
               zip: "80304")

shelter_2 = Shelter.create(name: "Forever Home Finder",
               address: "905 Manhattan Dr",
               city: "Boulder",
               state: "CO",
               zip: "80303")

shelter_2.pets.create(image: 'https://i.ytimg.com/vi/7NYaGOyJiCY/maxresdefault.jpg',
                      name: 'Stanislaus',
                      description: "Very lorge boy! Adopter must have a stable as he does not do well indoors. We're honestly all pretty terrified of him. Someone please come adopt him. We're begging you. Please...",
                      approximate_age: 75,
                      sex: 'male',
                      status: 'adoptable')

shelter_1.pets.create(image: 'https://i.imgur.com/RuDsNGNh.jpg',
                      name: 'DJ Ravioli',
                      description: "This cross-eyed catto loves bath time and rap time.",
                      approximate_age: 7,
                      sex: 'male',
                      status: 'adoptable')
shelter_1.pets.create(image: 'https://vetstreet.brightspotcdn.com/dims4/default/02bd838/2147483647/thumbnail/645x380/quality/90/?url=https%3A%2F%2Fvetstreet-brightspot.s3.amazonaws.com%2Fa3%2F767b00a33511e087a80050568d634f%2Ffile%2FSphynx-4-645mk062211.jpg',
                      name: 'Ruth Bader Ginspurrg',
                      description: 'Loves sweaters, impartiality, and serving her country.',
                      approximate_age: 12,
                      sex: 'female',
                      status: 'adoptable')
