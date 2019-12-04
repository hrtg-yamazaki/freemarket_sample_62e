FactoryBot.define do

  factory :address do

    last_name             { "山田" }
    first_name            { "太郎" }
    kana_last_name        { "ヤマダ" }
    kana_first_name       { "タロウ" }
    postal_code           { "123-4567" }
    prefecture_id         { 13 }
    city                  { "渋谷区" }
    block                 { "テスト坂1-1" }
    building              { "テストビル101" }
    tel                   { "09012345678" }
    association :user, factory: :user

  end

end