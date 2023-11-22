class AddColumnUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :postal_code, :string
    add_column :users, :self_introduction, :string
  end

  def down
    remove_column :users, :name, :string
    remove_column :users, :address, :string
    remove_column :users, :postal_code, :string
    remove_column :users, :self_introduction, :string
  end
end
