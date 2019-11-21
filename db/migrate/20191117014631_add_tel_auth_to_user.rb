class AddTelAuthToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tel_auth, :string, null: false
  end
end
