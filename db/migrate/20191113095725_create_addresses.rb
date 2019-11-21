class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :last_name,       null: false 
      t.string :first_name,      null: false 
      t.string :kana_last_name,  null: false 
      t.string :kana_first_name, null: false 
      t.string :postal_code,     null: false 
      t.string :prefecture,      null: false 
      t.string :city,            null: false 
      t.string :block,            null: false
      t.string :building,        default: ""
      t.references :user,        foreign_key: true
      t.timestamps
    end
  end
end
