FactoryBot.define do
  factory :image do
    image_url      { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_image.jpg')) }
    created_at     { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    updated_at     { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    association :item, factory: :item
  end
end