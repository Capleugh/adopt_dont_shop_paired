class CreateAdoptionAppPets < ActiveRecord::Migration[5.1]
  def change
    create_table :adoption_app_pets do |t|
      t.references :pet, foreign_key: true
      t.references :adoption_app, foreign_key: true

      t.timestamps
    end
  end
end
