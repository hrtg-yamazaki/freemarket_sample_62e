# DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|tel_auth|integer|unique: true|
|profile|text||
|lastname|string||
|firstname|string||
|f_last|string||
|f_first|string||
|prefecture|string||
|address1|string||
|address2|string||
|address3|string||
|tel|integer|null: false, index: true|
|birthday|integer||
|facebook|string||
|google|string||
|cardnum|integer||
|expdate|integer||
|profit|integer||
|point|integer||
### Association
- has_many :b_items, class_name: "Item"
- has_many :s_items, class_name: "Item"



## newsテーブル
|Column|Type|Options|
|------|----|-------|
|title|text|null: false|
|text|text|null: false|
|date|datetime|null: false|
### Association


## noticeテーブル
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
|image1|string|null: false|
|image2|string||
|image3|string||
|image4|string||
|image5|string||
|image6|string||
|image7|string||
|image8|string||
|image9|string||
|image10|string||
|buyer_id|reference|foreign_key: true|
|seller_id|reference|foreign_key: true|
### Association
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- belongs_to :categories
- belongs_to :brands

## brands
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items
- belongs_to :categories

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
### Association
- belongs_to :items
- belongs_to :users


## likesテーブル
|Column|Type|Options|
|------|----|-------|
|fine|integer||
|good|integer||
|bad|integer||
### Association
