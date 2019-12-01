class AddDefaultToImageImageUrl < ActiveRecord::Migration[5.2]
  def change
    change_column_default :images, :image_url, 'no image'
  end
end
