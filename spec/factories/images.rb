FactoryBot.define do
  factory :image do
    image_url      { File.open("#{Rails.root}/public/images/test_image.jpg") }
    item_id        { 1 }
    created_at     { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    updated_at     { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    association :item, factory: :item
  end
end