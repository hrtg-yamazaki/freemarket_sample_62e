class Address < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  belongs_to :user


  VALID_POSTAL_CODE_REGIX = /\A\d{3}[-]\d{4}\z/
  VALID_KATAKANA_REGIX    = /\A([ァ-ン]|ー)+\z/
  VALID_TEL_REGIX         = /\A\d{11}\z/

  validates :last_name,      presence: { message: "姓 を入力してください" },     on: :address_create, length: { maximum: 35, message:"35文字以下で入力してください" }
  validates :first_name,     presence: { message: "名 を入力してください" },     on: :address_create, length: { maximum: 35, message:"35文字以下で入力してください" }
  validates :kana_last_name, presence: { message: "姓カナ を入力してください" },  on: :address_create, length: { maximum: 35, message: "35文字以下で入力してください"}, format: { with: VALID_KATAKANA_REGIX , message: "カナ文字で入力してください"}
  validates :kana_last_name, presence: { message: "名カナ を入力してください" },   on: :address_create, length: { maximum: 35, message:"35文字以下で入力してください" }, format: { with: VALID_KATAKANA_REGIX, message: "カナ文字で入力してください"}
  validates :postal_code,    presence: { message: "郵便番号 を入力してください" }, on: :address_create, format: { with: VALID_POSTAL_CODE_REGIX, messages: "フォーマットが不適切です" } 
  validates :prefecture_id,  presence: { message: "都道府県 を選択してください" }, on: :address_create
  validates :city,           presence: { message: "市区町村 を入力してください" }, on: :address_create
  validates :block,          presence: { message: "番地 を入力してください" },     on: :address_create
  validates :tel,                                                              on: :address_create, format: { with: VALID_TEL_REGIX, messages:"電話番号を入力してください" }

end
