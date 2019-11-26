class Image < ApplicationRecord
  mount_uploader :image_url, ImageUploader

    # assositation
      belongs_to :item, optional: true


end
