class AddPrefectureIdToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :prefecture_id, :integer
  end
end
