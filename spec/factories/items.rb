FactoryBot.define do

  factory :item do

    name           { Faker::Commerce.product_name }
    text           { Faker::Lorem.sentence }
    condition      { 'bad' }
    price          { 1000 }
    size           { "Sサイズ" }
    defrayer       { 'included' }
    span           { 'maxTwo' }
    status         { 'onSell' }
    fav            { 0 }
    created_at     { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    updated_at     { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    prefecture_id  { 1 }

    association :seller, factory: :user
    association :buyer,  factory: :user

    after(:create) do |item|
      create_list(:image, 3, item: item)
    end

  end

end