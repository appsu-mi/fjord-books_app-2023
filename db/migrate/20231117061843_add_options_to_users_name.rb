class AddOptionsToUsersName < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :name, :string, unique: true, null: false
  end
end
