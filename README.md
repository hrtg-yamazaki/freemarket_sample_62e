# このアプリについて

## 概要
プログラミングスクールの最終課題として作成した、既存フリマアプリのコピーサイトです。4人チームで、アジャイル形式で開発を行いました。  
  
[動作確認はこちらをクリックしてください](http://13.114.37.243/)  
  
#### BASIC認証情報  
ID: 62teame  
PASSWORD: fmsample62e 

#### 開発担当箇所
・(サーバーサイド) ユーザー新規登録、ログイン  
・(フロントエンド) 商品出品ページ  
・(フロントエンド) 商品購入確認ページ  
・スクラムマスター ( チームの調整役 )  
・AWSへのデプロイ作業  
・DB設計  
・ルーティングの設定  


# DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false, unique: true, index: true|
|encrypted_password|string|null: false|
|reset_password_token|string|unique: true, index: true|
|reset_password_sent_at|datetime||
|remember_created_at|datetime||
|nickname|string|null: false|
|profile|text||
|last_name|string|null: false|
|first_name|string|null: false|
|kana_last_name|string|null: false|
|kana_first_name|string|null: false|
|birthday|integer|null: false|
|profit|integer||
|point|integer||
|tel_auth|string|null: false|
|provider|string||
|uid|string||
### Association
- has_many :buyed_items, class_name: "Item"
- has_many :selled_items, class_name: "Item"
- has_one :address
- has_one :card


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|last_name|string|null: false|
|first_name|string|null: false|
|kana_last_name|string|null: false|
|kane_first_name|string|null: false|
|postal_code|string|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string||
|user_id|references|foreign_key: true, index: true|
|tel|string||
|prefecture_id|integer||
### Association
- belongs_to :user


## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|pay_id|string|null: false|
|card_id|string|null: false|
|user_id|references|foreign_key: true, index: true|
### Association
- belongs_to :user


## newsテーブル
|Column|Type|Options|
|------|----|-------|
|title|text|null: false|
|text|text|null: false|
|date|datetime|null: false|
### Association


## noticesテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|link_url|string||
### Association


## todos
|Column|Type|Options|
|------|----|-------|
|title|text|null: false|
|text|text|null: false|
|date|datetime|null: false|
### Association


## items
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|text|text|null: false|
|condition|integer|null: false|
|price|integer|null: false|
|size|string||
|defrayer|integer|null: false|
|span|integer|null: false|
|status|integer|null: false|
|fav|integer||
|buyer_id|reference|foreign_key: true, index: true|
|seller_id|reference|foreign_key: true, index: true|
|prefecture_id|integer||
### Association
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- belongs_to :category
- belongs_to :brand
- has_many :images


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image_url|string|null: false|
|item_id|references|foreign_key: true, index: true|
### Association
belongs_to :item

## brands
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items
- belongs_to :category

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|genre_size|integer|null: false|
### Association
- has_many :items

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|user_id|references|foreign_key:true|
|item_id||references|foreign_key:true|
### Association
- belongs_to :item
- belongs_to :user


## likesテーブル
|Column|Type|Options|
|------|----|-------|
|fine|integer||
|good|integer||
|bad|integer||
### Association
