class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show,:edit,:update,:destroy]
  before_action :move_to_index, only: [:edit,:destroy]  

  def index
    @item = Item.all.order("created_at DESC")
  end
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    
    if @item.save 
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:image,:item_name,:description,:category_id,:condition_id,:fee_id,:prefecture_id,:waitingday_id,:price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    if !(current_user.id == @item.user_id) || !(@item.order.blank?)
      redirect_to action: :index
    end 
  end

end
