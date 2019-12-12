class AddDefaultToStatus < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :status

    add_column :pets, :status, :string, default: "Adoptable"
  end
end
