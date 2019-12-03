class RemoveTwoColumnsFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :facebook, :string
    remove_column :users, :google, :string
  end
end
