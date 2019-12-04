require 'rails_helper'

RSpec.describe Item, type: :model do 

  describe '#create' do

    context '保存できる' do
      it "全てのカラムが埋まっていたら保存できる" do
        item = build(:item)
        expect(item).to be_valid
      end

      it "size: nil でも保存できる" do
        item = build(:item, size: nil)
        expect(item).to be_valid
      end

      it "buyer_id: nil でも保存できる" do
        item = build(:item, buyer_id: nil)
        expect(item).to be_valid
      end

      it "name: 40文字 なら保存できる" do
        item = build(:item, name: "aaaaaaaaaabbbbbbbbbbccccccccccdddddddddd")
        expect(item).to be_valid
      end

      it "text: 1000文字 なら保存できる" do
        item = build(:item, text: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        expect(item).to be_valid
      end

      it "price: 300 なら保存できる" do
        item = build(:item, price: 300)
        expect(item).to be_valid
      end

      it "price: 9999999 なら保存できる" do
        item = build(:item, price: 9999999)
        expect(item).to be_valid
      end
    end
    
    context '保存できない' do
      it "name: nil では保存できない" do
        item = build(:item, name: nil)
        item.valid?
        expect(item.errors[:name]).to include("商品名 を入力してください")
      end

      it "name: 41文字 では保存できない" do
        item = build(:item, name: "aaaaaaaaaabbbbbbbbbbccccccccccdddddddddde")
        item.valid?
        expect(item.errors[:name]).to include("商品名 は40文字以内で入力してください")
      end

      it "text: nil では保存できない" do
        item = build(:item, text: nil)
        item.valid?
        expect(item.errors[:text]).to include("商品の説明 を入力してください")
      end

      it "text: 1001文字 では保存できない" do
        item = build(:item, text: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab")
        item.valid?
        expect(item.errors[:text]).to include("商品の説明 は1000文字以内で入力してください")
      end

      it "condition: nil では保存できない" do 
        item = build(:item, condition: nil)
        item.valid?
        expect(item.errors[:condition]).to include("商品の状態 を選択してください")
      end

      it "defrayer: nil では保存できない" do
        item = build(:item, defrayer: nil)
        item.valid?
        expect(item.errors[:defrayer]).to include("配送料の負担 を選択してください")
      end

      it "prefecture_id: nilでは保存できない" do
        item = build(:item, prefecture_id: nil)
        item.valid?
        expect(item.errors[:prefecture_id]).to include("発送元の地域 を選択してください")
      end

      it "span: nil では保存できない" do
        item = build(:item, span: nil)
        item.valid?
        expect(item.errors[:span]).to include("発送までの日数 を選択してください")
      end

      it "price: nil では保存できない" do
        item = build(:item, price: nil)
        item.valid?
        expect(item.errors[:price]).to include("価格 は300以上9999999以下の数字で入力してください")
      end

      it "price: 数字以外の文字は保存できない" do
        item = build(:item, price: "aaaa")
        item.valid?
        expect(item.errors[:price]).to include("価格 は300以上9999999以下の数字で入力してください")
      end
      
      it "price: 整数以外の数字は保存できない" do
        item = build(:item, price: 0.5)
        item.valid?
        expect(item.errors[:price]).to include("価格 は300以上9999999以下の数字で入力してください")
      end

      it "price: 299 では保存できない"  do
        item = build(:item, price: 299)
        item.valid?
        expect(item.errors[:price]).to include("価格 は300以上9999999以下の数字で入力してください")
      end

      it "price: 10000000 では保存できない"  do
        item = build(:item, price: 10000000)
        item.valid?
        expect(item.errors[:price]).to include("価格 は300以上9999999以下の数字で入力してください")
      end

    end    
  end


end