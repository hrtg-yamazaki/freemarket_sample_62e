class Address < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  belongs_to :user


  def self.select_prefecture
    return ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
            "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
            "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県",
            "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳥取県",
            "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県",
            "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"]
  end

  VALID_POSTAL_CODE_REGIX = /\A\d{3}[-]\d{4}\z/
  VALID_KATAKANA_REGIX    = /\A([ァ-ン]|ー)+\z/
  VALID_TEL_REGIX         = /\A\d{11}\z/

  validates :last_name,      presence: true, on: :address_create, length: { maximum: 35 }
  validates :first_name,     presence: true, on: :address_create, length: { maximum: 35 }
  validates :kana_last_name, presence: true, on: :address_create, length: { maximum: 35 }, format: { with: VALID_KATAKANA_REGIX }
  validates :kana_last_name, presence: true, on: :address_create, length: { maximum: 35 }, format: { with: VALID_KATAKANA_REGIX }
  validates :postal_code,    presence: true, on: :address_create, format: { with: VALID_POSTAL_CODE_REGIX } 
  validates :prefecture,     presence: true, on: :address_create
  validates :city,           presence: true, on: :address_create
  validates :tel,                            on: :address_create, format: { with: VALID_TEL_REGIX }

end
