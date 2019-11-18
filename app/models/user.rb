class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address, dependent: :destroy


  VALID_KATAKANA_REGIX = /\A([ァ-ン]|ー)+\z/
  VALID_PASSWORD_REGIX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}+\z/i
  VALID_SMS_REGIX = /\A\d{11}\z/

  validates :nickname,       presence: true, on: :registration_post, length: { maximum: 20 }
  validates :email,          presence: true, on: :registration_post
  validates :password,       presence: true, on: :registration_post, format: { with: VALID_PASSWORD_REGIX }
  validates :last_name,      presence: true, on: :registration_post, length: { maximum: 35 }
  validates :first_name,     presence: true, on: :registration_post, length: { maximum: 35 }
  validates :kana_last_name, presence: true, on: :registration_post, length: { maximum: 35 }, format: { with: VALID_KATAKANA_REGIX }
  validates :kana_last_name, presence: true, on: :registration_post, length: { maximum: 35 }, format: { with: VALID_KATAKANA_REGIX }
  validates :birthday,       presence: true, on: :registration_post
  validates :tel_auth,       presence: true, on: :confirmation_post, format: { with: VALID_SMS_REGIX }
  
end
