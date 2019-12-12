class AddPendingToAdoptionAppsPets < ActiveRecord::Migration[5.1]
  def change

    add_column :adoption_app_pets, :status, :string, default: "this_application_is_not_approved_for_this_pet"
  end 
end
