class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_one :address, dependent: :destroy
  has_one :card,    dependent: :destroy
  has_many :buyed_items, class_name: "Item"
  has_many :selled_items, class_name: "Item"


  VALID_KATAKANA_REGIX = /\A([ァ-ン]|ー)+\z/
  VALID_EMAIL_REGIX    = /\A[^@\s]+@[^@\s]+\z/
  VALID_PASSWORD_REGIX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}+\z/i
  VALID_SMS_REGIX      = /\A\d{11}\z/

  validates :nickname,       presence: { message: "ニックネーム を入力してください" },   on: :registration_post, length: { maximum: 20, message: "20文字以下で入力してください" }
  validates :email,          presence: { message: "メールアドレス を入力してください" }, on: :registration_post,                                                               format: { with: VALID_EMAIL_REGIX,   message: "フォーマットが不適切です"}
  validates :password,       presence: { message: "パスワード を入力してください" },     on: :registration_post,                                                               format: { with: VALID_PASSWORD_REGIX, message: "英字と数字両方を含むパスワードを入力してください" }
  validates :last_name,      presence: { message: "姓 を入力してください" },           on: :registration_post, length: { maximum: 35, message: "35文字以下で入力してください" }
  validates :first_name,     presence: { message: "名 を入力してください" },           on: :registration_post, length: { maximum: 35, message: "35文字以下で入力してください" }
  validates :kana_last_name, presence: { message: "姓カナ を入力してください" },        on: :registration_post, length: { maximum: 35, message: "35文字以下で入力してください" }, format: { with: VALID_KATAKANA_REGIX, message: "姓カナは カナ文字を入力してください" }
  validates :kana_last_name, presence: { message: "名カナ を入力してください" },        on: :registration_post, length: { maximum: 35, message: "35文字以下で入力してください" }, format: { with: VALID_KATAKANA_REGIX, message: "名カナは カナ文字を入力してください" }
  validates :birthday,       presence: { message: "生年月日 を入力してください" },      on: :registration_post
  validates :tel_auth,       presence: { message: "会員登録できません" },              on: :confirmation_post,                                                               format: { with: VALID_SMS_REGIX,     message: "携帯電話番号 を入力してください" }
  

#SNS関連

   def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.new(
        uid:      auth.uid,
        provider: auth.provider,
        nickname: auth.info.name,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        last_name: "",
        first_name: "",
        kana_last_name: "",
        kana_first_name: "",
        birthday: Date.new(2000,11,11),
        tel_auth: ""
      )
    end
    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end