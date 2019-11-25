FactoryBot.define do
  factory :item do
    name       { "天球儀リング シルバー ギメルリング" }
    text       { "珍しくて美しい、神秘的なリングです。閉じた状態から展開すると、アンティークな天球儀風に変形します。入手困難なアイテムです。" }
    condition  { 0 }
    price      { 1000 }
    size       { "Sサイズ" }
    defrayer   { 0 }
    area       { 0 }
    span       { 0 }
    fav        { 0 }
    status     { 0 }
    buyer_id   { nil }
    seller_id  { 1 }
  end
end