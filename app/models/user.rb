class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :validatable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable 

  has_one :address, dependent: :destroy


  VALID_KATAKANA_REGIX = /\A([ァ-ン]|ー)+\z/
  VALID_EMAIL_REGIX    = /\A[^@\s]+@[^@\s]+\z/
  VALID_PASSWORD_REGIX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}+\z/i
  VALID_SMS_REGIX      = /\A\d{11}\z/

  validates :nickname,       presence: { message: "ニックネーム を入力してください" }, length: { maximum: 20, message: "20文字以下で入力してください" }
  validates :email,          presence: { message: "メールアドレス を入力してください" },                                                             format: { with: VALID_EMAIL_REGIX,   message: "フォーマットが不適切です"}
  validates :password,       presence: { message: "パスワード を入力してください" },                                                                format: { with: VALID_PASSWORD_REGIX, message: "英字と数字両方を含むパスワードを入力してください" }
  validates :last_name,      presence: { message: "姓 を入力してください" },         length: { maximum: 35, message: "35文字以下で入力してください" }
  validates :first_name,     presence: { message: "名 を入力してください" },         length: { maximum: 35, message: "35文字以下で入力してください" }
  validates :kana_last_name, presence: { message: "姓カナ を入力してください" },      length: { maximum: 35, message: "35文字以下で入力してください" }, format: { with: VALID_KATAKANA_REGIX, message: "姓カナは カナ文字を入力してください" }
  validates :kana_last_name, presence: { message: "名カナ を入力してください" },      length: { maximum: 35, message: "35文字以下で入力してください" }, format: { with: VALID_KATAKANA_REGIX, message: "名カナは カナ文字を入力してください" }
  validates :birthday,       presence: { message: "生年月日 を入力してください" }
  validates :tel_auth,       presence: { message: "会員登録できません" },                                                                          format: { with: VALID_SMS_REGIX,     message: "携帯電話番号 を入力してください" }
  
end
