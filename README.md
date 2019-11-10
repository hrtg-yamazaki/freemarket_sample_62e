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
|prefectere|string||
|address1|string||
|address2|string||
|address3|string||
|tel|integer|null: false, index: true,unique: true|
|birthday|integer||
|facebook|string||
|twitter|string||
|google|string||
|cardnum|integer||
|expdate|integer||
|profit|integer||
|point|v||
### Association
- has_many :items
- has_many :comments
- has_one :news


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
|title|text|null: false|
|date|datetime|null: false|
|link_url|references|foreign_key: true|
### Association


## todo
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
|price|inrteger|null: false|
|size|string||
|cost|integer|null: false|
|area|integer|null: false|
|span|integer|null: false|
|selled_now|boolean||
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
### Association
- belongs_to :users
- belongs_to :categorys
- belongs_to :brands

## brands
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items
- belongs_to :categorys

## categorysテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items
- belongs_to :subgenres


### subgenres
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :sategorys
- belongs_to :genres


### genres
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :subgenres


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
### Association
- belongs_to :items
- belongs_to :users


## likeテーブル
|Column|Type|Options|
|------|----|-------|
|fine|integer||
|good|integer||
|bad|integer||
### Association
