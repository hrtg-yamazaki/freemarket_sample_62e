class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    
    add_column :users, :nickname, :string, null: false
    add_column :users, :tel_auth, :integer, null: false
    add_column :users, :profile, :text
    add_column :users, :last_name, :string, null: false
    add_column :users, :first_name, :string, null: false
    add_column :users, :kana_last_name, :string, null: false
    add_column :users, :kana_first_name, :string, null: false
    add_column :users, :tel, :integer
    add_column :users, :birthday, :date, null: false
    add_column :users, :facebook, :string
    add_column :users, :google, :string
    add_column :users, :card_num, :integer, null: false
    add_column :users, :exp_date, :integer, null: false
    add_column :users, :sec_code, :integer, null: false
    add_column :users, :profit, :integer
    add_column :users, :point, :integer

  end
end
