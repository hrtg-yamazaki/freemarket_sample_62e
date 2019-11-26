class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name            ,null: false
      t.text :text              ,null: false
      t.integer :condition
      t.integer :price          ,null: false
      t.string :size
      t.integer :defrayer       ,null: false
      t.integer :area           ,null: false
      t.integer :span           ,null: false
      t.integer :status         ,null: false
      t.integer :fav            ,default: 0
      t.references :buyer                    ,foreign_key: { to_table: :users } ,optional: true
      t.references :seller      ,null: false ,foreign_key: { to_table: :users }      
      t.timestamps
    end
  end
end
