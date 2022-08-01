class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :address1, :address2, :building_name, :phone_number
  attr_accessor :token, :price

  with_options presence: true do
    validates :user_id        
    validates :item_id
    validates :post_code      ,format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "input correctly"}
    validates :prefecture_id  ,numericality: {other_than: 1, message: "select"}
    validates :address1       
    validates :address2
    validates :phone_number   ,format: {with: /\A\d{10,11}\z/, message: "is invalid."}
    validates :token          
    validates :price
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, address1: address1, address2: address2, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end

end
