require "rails_helper"

RSpec.describe Address, type: :model do

  describe "signup#address_create" do

    context "保存できる" do

      it "全てのカラムが埋まっていれば保存できる" do
        address = build(:address)
        address.valid?(:address_create)
        expect(address).to be_valid
      end

      it "last_nameが35文字以下ならば保存できる" do
        address = build(:address, last_name: "あかさたなはまやらわあかさたなはまやらわあかさたなはまやらわあかさたな")
        address.valid?(:address_create)
        expect(address).to be_valid
      end

      it "first_nameが35文字以下ならば保存できる" do
        address = build(:address, first_name: "あかさたなはまやらわあかさたなはまやらわあかさたなはまやらわあかさたな")
        address.valid?(:address_create)
        expect(address).to be_valid
      end

      it "kana_last_nameが35文字以下ならば保存できる" do
        address = build(:address, kana_last_name: "アカサタナハマヤラワアカサタナハマヤラワアカサタナハマヤラワアカサタナ")
        address.valid?(:address_create)
        expect(address).to be_valid
      end

      it "kana_first_nameが35文字以下ならば保存できる" do
        address = build(:address, kana_first_name: "アカサタナハマヤラワアカサタナハマヤラワアカサタナハマヤラワアカサタナ")
        address.valid?(:address_create)
        expect(address).to be_valid
      end

      it "buildingが空でも保存できる" do
        address = build(:address, building: nil)
        address.valid?(:address_create)
        expect(address).to be_valid
      end

      it "telが空でも保存できる" do
        address = build(:address, tel: nil)
        address.valid?(:address_create)
        expect(address).to be_valid
      end

      it "telが10桁ならば保存できる" do
        address = build(:address, tel: "1234567890")
        address.valid?(:address_create)
        expect(address).to be_valid
      end

      it "telが11桁ならば保存できる" do
        address = build(:address, tel: "12345678901")
        address.valid?(:address_create)
        expect(address).to be_valid
      end

      it "telとbuildingが空でも他が全て埋まっていれば保存できる" do
        address = build(:address, building: nil, tel: nil)
        address.valid?(:address_create)
        expect(address).to be_valid
      end

    end
  
    context "保存できない" do
      
      it "last_nameが空では保存できない" do
        address = build(:address, last_name: "")
        address.valid?(:address_create)
        expect(address.errors[:last_name]).to include("姓 を入力してください")
      end

      it "last_nameが36文字以上では保存できない" do
        address = build(:address, last_name: "あかさたなはまやらわあかさたなはまやらわあかさたなはまやらわあかさたなハ")
        address.valid?(:address_create)
        expect(address.errors[:last_name]).to include("35文字以下で入力してください")
      end

      it "first_nameが空では保存できない" do
        address = build(:address, first_name: "")
        address.valid?(:address_create)
        expect(address.errors[:first_name]).to include("名 を入力してください")
      end

      it "first_nameが36文字以上では保存できない" do
        address = build(:address, first_name: "あかさたなはまやらわあかさたなはまやらわあかさたなはまやらわあかさたなハ")
        address.valid?(:address_create)
        expect(address.errors[:first_name]).to include("35文字以下で入力してください")
      end

      it "kana_last_nameが空では保存できない" do
        address = build(:address, kana_last_name: "")
        address.valid?(:address_create)
        expect(address.errors[:kana_last_name]).to include("姓カナ を入力してください")
      end

      it "kana_last_nameが36文字以上では保存できない" do
        address = build(:address, kana_last_name: "アカサタナハマヤラワアカサタナハマヤラワアカサタナハマヤラワアカサタナハ")
        address.valid?(:address_create)
        expect(address.errors[:kana_last_name]).to include("35文字以下で入力してください")
      end

      it "kana_last_nameがカナ文字以外を含むと保存できない" do
        address = build(:address, kana_last_name: "あカサタナハマヤラワ")
        address.valid?(:address_create)
        expect(address.errors[:kana_last_name]).to include("カナ文字で入力してください")
      end

      it "kana_first_nameが空では保存できない" do
        address = build(:address, kana_first_name: "")
        address.valid?(:address_create)
        expect(address.errors[:kana_first_name]).to include("名カナ を入力してください")
      end

      it "kana_first_nameが36文字以上では保存できない" do
        address = build(:address, kana_first_name: "アカサタナハマヤラワアカサタナハマヤラワアカサタナハマヤラワアカサタナハ")
        address.valid?(:address_create)
        expect(address.errors[:kana_first_name]).to include("35文字以下で入力してください")
      end

      it "kana_first_nameがカナ文字以外を含むと保存できない" do
        address = build(:address, kana_first_name: "あカサタナハマヤラワ")
        address.valid?(:address_create)
        expect(address.errors[:kana_first_name]).to include("カナ文字で入力してください")
      end

      it "postal_codeが空では保存できない" do
        address = build(:address, postal_code: "")
        address.valid?(:address_create)
        expect(address.errors[:postal_code]).to include("郵便番号 を入力してください")
      end

      it "prefecture_idが空では保存できない" do
        address = build(:address, prefecture_id: "")
        address.valid?(:address_create)
        expect(address.errors[:prefecture_id]).to include("都道府県 を選択してください")
      end

      it "cityが空では保存できない" do
        address = build(:address, city: "")
        address.valid?(:address_create)
        expect(address.errors[:city]).to include("市区町村 を入力してください")
      end

      it "blockが空では保存できない" do
        address = build(:address, block: "")
        address.valid?(:address_create)
        expect(address.errors[:block]).to include("番地 を入力してください")
      end

      it "telが10桁以下では登録できない" do
        address = build(:address, tel: "123456789")
        address.valid?(:address_create)
        expect(address.errors[:tel]).to include("電話番号 を入力してください")
      end

      it "telが12桁以上では登録できない" do
        address = build(:address, tel: "123456789012")
        address.valid?(:address_create)
        expect(address.errors[:tel]).to include("電話番号 を入力してください")
      end

      it "ユーザーとの関連付けがなければ登録できない" do
        address = build(:address, user: nil)
        address.valid?(:address_create)
        expect(address.errors[:user]).to include("を入力してください")
      end

    end

  end
  
end

# it "全てのカラムが埋まっていれば保存できる" do
#   address = build(:address)
#   address.valid?(:address_create)
#   expect(address).to be_valid
# end
