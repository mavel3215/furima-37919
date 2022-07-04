#テーブル設計

##users テーブル
|Column              |Type    |Options                  |
|--------------------|--------|-------------------------|
|email               |string  |null: false, unique: true|
|encrypted_password  |string  |null: false              |
|nickname            |string  |null: false              |
|first_name          |string  |null: false              |
|last_name           |string  |null: false              |
|first_name_katakana |string  |null: false              |
|last_name_katakana  |string  |null: false              |
|birthday            |date    |null: false              |


### Association
- has_many :items
- has_one  :order


##items テーブル
|Column     |Type      |Options                       |
|-----------|----------|------------------------------|
|item_name  |string    |null: false                   |
|description|text      |null: false                   |
|category   |string    |null: false                   |
|condition  |string    |null: false                   |
|fee        |integer   |null: false                   |
|ship_from  |string    |null: false                   |
|waiting_day|integer   |null: false                   |
|price      |integer   |null: false                   |
|user       |references|null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one  :order

##orders テーブル
|Column       |Type      |Options                       |
|---------    |----------|------------------------------|
|card_number  |integer   |null: false                   |
|expire_date  |date      |null: false                   |
|security_code|integer   |null: false                   |
|post_code    |integer   |null: false                   |
|prefecture   |string    |null: false                   |
|address1     |string    |null: false                   |
|address2     |string    |null: false                   |
|building_name|string    |null: false                   |
|phone_number |integer   |null: false                   |
|user         |references|null: false, foreign_key: true|
|item         |references|null: false, foreign_key: true|

### Association
- has_one  :user
- has_one  :item