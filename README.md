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
- has_many :orders


##items テーブル
|Column        |Type      |Options                       |
|--------------|----------|------------------------------|
|item_name     |string    |null: false                   |
|description   |text      |null: false                   |
|category_id   |integer   |null: false                   |
|condition_id  |integer   |null: false                   |
|fee_id        |integer   |null: false                   |
|prefecture_id |integer   |null: false                   |
|waiting_day_id|integer   |null: false                   |
|price         |integer   |null: false                   |
|user          |references|null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one  :order


##orders テーブル
|Column       |Type      |Options                       |
|-------------|----------|------------------------------|
|user         |references|null: false, foreign_key: true|
|item         |references|null: false, foreign_key: true|


### Association
- belongs_to :user
- belongs_to :item
- has_one: address


##addressesテーブル
|Column       |Type      |Options                       |
|-------------|----------|------------------------------|
|post_code    |string    |null: false                   |
|prefecture_id|integer   |null: false                   |
|address1     |string    |null: false                   |
|address2     |string    |null: false                   |
|building_name|string    |                              |
|phone_number |string    |null: false                   |
|order        |references|null: false, foreign_key: true|

### Association
- belongs_to :order
