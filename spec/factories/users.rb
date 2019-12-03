FactoryBot.define do

  factory :user do
    nickname              { "テスト太郎" }
    email                 { "usertest@usertest.com" }
    password              { "test1234" }
    password_confirmation { "test1234" }
    profile               { nil }
    last_name             { "山田" }
    first_name            { "太郎" }
    kana_last_name        { "ヤマダ" }
    kana_first_name       { "タロウ" }
    birthday              { Date.new(1990, 01, 01) }
    profit                { 0 }
    point                 { 0 }
    tel_auth              { "09012345678" }
    provider              { "testprovider" }
    uid                   { "123456789012345678901" }
  end

end