class RemoveTelAuthFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :tel_auth, :integer
  end
end
