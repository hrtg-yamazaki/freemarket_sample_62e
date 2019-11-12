# DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|tel_auth|integer|unique: true|
|profile|text||
|last_name|string||
|first_name|string||
|kana_last_name|string||
|kana_first_name|string||
|tel|integer|null: false, index: true|
|birthday|integer||
|facebook|string||
|google|string||
|card_num|integer||
|exp_date|integer||
|profit|integer||
|point|integer||
### Association
- has_many :buyed_items, class_name: "Item"
- has_many :selled_items, class_name: "Item"
- has_one :address


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|prefecture|string||
|city|string|null: false|
|block|string|null: false|
|building|string||
|user_id|references|foreign_key: true|
### Association
belongs_to :user

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
|condition|integer||
|price|integer|null: false|
|size|string||
|defrayer|integer|null: false|
|area|integer|null: false|
|span|integer|null: false|
|selled_now|boolean|default: null|
|fav|integer||
|buyer_id|reference|foreign_key: true|
|seller_id|reference|foreign_key: true|
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
|item_id|references|foreign_key:true|
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
