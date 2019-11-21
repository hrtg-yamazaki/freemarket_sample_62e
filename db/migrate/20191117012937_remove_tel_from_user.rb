class RemoveTelFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :tel, :integer
  end
end
