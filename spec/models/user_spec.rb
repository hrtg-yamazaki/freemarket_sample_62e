## 新規登録のテスト ##

require "rails_helper"

RSpec.describe User, type: :model do
  
  describe "signup#registration_post" do
    
    context "sessionに保存できる" do

      it "全てのカラムが埋まっていれば保存できる" do
        user = build(:user)
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "nicknameが20文字以下であれば保存できる" do
        user = build(:user, nickname: "1234567890abcdfghijk")
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "emailが @ を含む英数字であれば保存できる" do
        user = build(:user, email: "test@test.com")
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "passwordが7文字以上ならば保存できる" do
        user = build(:user, password: "tech123")
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "passwordが128文字以下ならば保存できる" do
        user = build(:user, password: "12345abcde12345abcde12345abcde12345abcde12345abcde12345abcde12345abcde12345abcde12345abcde12345abcde12345abcde12345abcde12345678")
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "last_nameが35文字以下ならば保存できる" do
        user = build(:user, last_name: "あかさたなはまやらわあかさたなはまやらわあかさたなはまやらわあかさたな")
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "first_nameが35文字以下ならば保存できる" do
        user = build(:user, first_name: "あかさたなはまやらわあかさたなはまやらわあかさたなはまやらわあかさたな")
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "kana_last_nameが35文字以下ならば保存できる" do
        user = build(:user, kana_last_name: "アカサタナハマヤラワアカサタナハマヤラワアカサタナハマヤラワアカサタナ")
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "kana_first_nameが35文字以下ならば保存できる" do
        user = build(:user, kana_first_name: "アカサタナハマヤラワアカサタナハマヤラワアカサタナハマヤラワアカサタナ")
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "birthdayがdate型で存在すれば保存できる" do
        user = build(:user, birthday: Date.new(1990, 04, 02))
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "profileがnilでも保存できる" do
        user = build(:user, profile: nil)
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "profitがnilでも保存できる" do
        user = build(:user, profit: nil)
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "pointがnilでも保存できる" do
        user = build(:user, point: nil)
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "providerがnilでも保存できる" do
        user = build(:user, provider: nil)
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

      it "uidがnilでも保存できる" do
        user = build(:user, uid: nil)
        user.valid?(:registration_post)
        expect(user).to be_valid
      end

    end

    context "sessionに保存できない" do
      
      it "nicknameが空では保存できない" do
        user = build(:user, nickname: "")
        user.valid?(:registration_post)
        expect(user.errors[:nickname]).to include("ニックネーム を入力してください")
      end

      it "nicknameが21文字以上では保存できない" do
        user = build(:user, nickname: "01234567890abcdfghijk")
        user.valid?(:registration_post)
        expect(user.errors[:nickname]).to include("20文字以下で入力してください")
      end

      it "emailが空では保存できない" do
        user = build(:user, email: "")
        user.valid?(:registration_post)
        expect(user.errors[:email]).to include("メールアドレス を入力してください")
      end

      it "emailが@を含まなければ保存できない" do
        user = build(:user, email: "testtest.com")
        user.valid?(:registration_post)
        expect(user.errors[:email]).to include("フォーマットが不適切です")
      end

      it "passwordが空では保存できない" do
        user = build(:user, password: "")
        user.valid?(:registration_post)
        expect(user.errors[:password]).to include("パスワード を入力してください")
      end

      it "passwordが6文字以下では保存できない" do
        user = build(:user, password: "pass12")
        user.valid?(:registration_post)
        expect(user.errors[:password]).to include("英字と数字両方を含むパスワードを入力してください")
      end

      it "passwordが129文字以上では保存できない" do
        user = build(:user, password: "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678a")
        user.valid?(:registration_post)
        expect(user.errors[:password]).to include("128文字以下で入力してください")
      end

      it "passwordが数字のみでは登録できない" do
        user = build(:user, password: "1234567890")
        user.valid?(:registration_post)
        expect(user.errors[:password]).to include("英字と数字両方を含むパスワードを入力してください")
      end

      it "passwordが英字のみでは登録できない" do
        user = build(:user, password: "abcdefghij")
        user.valid?(:registration_post)
        expect(user.errors[:password]).to include("英字と数字両方を含むパスワードを入力してください")
      end

      it "last_nameが空では保存できない" do
        user = build(:user, last_name: "")
        user.valid?(:registration_post)
        expect(user.errors[:last_name]).to include("姓 を入力してください")
      end

      it "last_nameが36文字以上では保存できない" do
        user = build(:user, last_name: "あかさたなはまやらわあかさたなはまやらわあかさたなはまやらわあかさたなハ")
        user.valid?(:registration_post)
        expect(user.errors[:last_name]).to include("35文字以下で入力してください")
      end

      it "first_nameが空では保存できない" do
        user = build(:user, first_name: "")
        user.valid?(:registration_post)
        expect(user.errors[:first_name]).to include("名 を入力してください")
      end

      it "first_nameが36文字以上では保存できない" do
        user = build(:user, first_name: "あかさたなはまやらわあかさたなはまやらわあかさたなはまやらわあかさたなハ")
        user.valid?(:registration_post)
        expect(user.errors[:first_name]).to include("35文字以下で入力してください")
      end

      it "kana_last_nameが空では保存できない" do
        user = build(:user, kana_last_name: "")
        user.valid?(:registration_post)
        expect(user.errors[:kana_last_name]).to include("姓カナ を入力してください")
      end

      it "kana_last_nameが36文字以上では保存できない" do
        user = build(:user, kana_last_name: "アカサタナハマヤラワアカサタナハマヤラワアカサタナハマヤラワアカサタナハ")
        user.valid?(:registration_post)
        expect(user.errors[:kana_last_name]).to include("35文字以下で入力してください")
      end

      it "kana_last_nameがカナ文字以外を含むと保存できない" do
        user = build(:user, kana_last_name: "あカサタナハマヤラワ")
        user.valid?(:registration_post)
        expect(user.errors[:kana_last_name]).to include("姓カナは カナ文字を入力してください")
      end

      it "kana_first_nameが空では保存できない" do
        user = build(:user, kana_first_name: "")
        user.valid?(:registration_post)
        expect(user.errors[:kana_first_name]).to include("名カナ を入力してください")
      end

      it "kana_first_nameが36文字以上では保存できない" do
        user = build(:user, kana_first_name: "アカサタナハマヤラワアカサタナハマヤラワアカサタナハマヤラワアカサタナハ")
        user.valid?(:registration_post)
        expect(user.errors[:kana_first_name]).to include("35文字以下で入力してください")
      end

      it "kana_first_nameがカナ文字以外を含むと保存できない" do
        user = build(:user, kana_first_name: "あカサタナハマヤラワ")
        user.valid?(:registration_post)
        expect(user.errors[:kana_first_name]).to include("名カナは カナ文字を入力してください")
      end

      it "birthdayが空では保存できない" do
        user = build(:user, birthday: "")
        user.valid?(:registration_post)
        expect(user.errors[:birthday]).to include("生年月日 を入力してください")
      end

      it "birthdayが空では保存できない" do
        user = build(:user, birthday: "")
        user.valid?(:registration_post)
        expect(user.errors[:birthday]).to include("生年月日 を入力してください")
      end
      
    end
  end

  describe "signup#confirmation_post" do
    
    context "保存できる" do
      
      it "全てのカラムが埋まっていれば保存できる" do
        user = build(:user)
        user.valid?(:confirmation_post)
        expect(user).to be_valid
      end

      it "tel_authが11桁の数字であれば保存できる" do
        user = build(:user, tel_auth: "08012345678")
        user.valid?(:confirmation_post)
        expect(user).to be_valid
      end

      it "profileがnilでも保存できる" do
        user = build(:user, profile: nil)
        user.valid?(:confirmation_post)
        expect(user).to be_valid
      end

      it "profitがnilでも保存できる" do
        user = build(:user, profit: nil)
        user.valid?(:confirmation_post)
        expect(user).to be_valid
      end

      it "pointがnilでも保存できる" do
        user = build(:user, point: nil)
        user.valid?(:confirmation_post)
        expect(user).to be_valid
      end

      it "providerがnilでも保存できる" do
        user = build(:user, provider: nil)
        user.valid?(:confirmation_post)
        expect(user).to be_valid
      end

      it "uidがnilでも保存できる" do
        user = build(:user, uid: nil)
        user.valid?(:confirmation_post)
        expect(user).to be_valid
      end

    end

    context "保存できない" do
      
      it "tel_authが空では保存できない" do
        user = build(:user, tel_auth: "")
        user.valid?(:confirmation_post)
        expect(user.errors[:tel_auth]).to include("会員登録できません")
      end

      it "tel_authが12桁以上では保存できない" do
        user = build(:user, tel_auth: "090123456789")
        user.valid?(:confirmation_post)
        expect(user.errors[:tel_auth]).to include("携帯電話番号 を入力してください")
      end

      it "tel_authが10桁以下では保存できない" do
        user = build(:user, tel_auth: "0901234567")
        user.valid?(:confirmation_post)
        expect(user.errors[:tel_auth]).to include("携帯電話番号 を入力してください")
      end

      it "tel_authに半角数字以外が含まれていると保存できない" do
        user = build(:user, tel_auth: "0901234５678")
        user.valid?(:confirmation_post)
        expect(user.errors[:tel_auth]).to include("携帯電話番号 を入力してください")
      end

    end

  end

end




