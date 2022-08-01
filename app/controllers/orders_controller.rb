class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

  def index
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
    
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :address1, :address2, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token], price: Item.find(params[:item_id]).price)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: order_params[:price],
      card: order_params[:token],
      currency: "jpy"
    )
  end

  def move_to_index
    if current_user.id == Item.find(params[:item_id]).user_id || !(current_user.id == Item.find(params[:item_id]).user_id) && !(Item.find(params[:item_id]).order.blank?)
      redirect_to root_path
    end 
  end
  
end
