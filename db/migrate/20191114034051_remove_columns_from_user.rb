class RemoveColumnsFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :card_num, :integer, null: false
    remove_column :users, :exp_date, :integer, null: false
    remove_column :users, :sec_code, :integer, null: false
  end
end
