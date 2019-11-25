class AddPrefectureIdToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :prefecture_id, :integer
  end
end
