class AddDefaultToItemStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :items, :status, 0
  end
end
