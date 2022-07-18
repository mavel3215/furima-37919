require 'rails_helper'

RSpec.describe Item, type: :model do

  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品できる場合' do
      it "必要な情報を適切に入力して「出品する」ボタンを押すと、商品情報がデータベースに保存される" do
        expect(@item).to be_valid
      end
    end
    context '商品出品できない場合' do
      it "商品画像がなければ出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "商品名が無記名では出品できない" do
        @item.item_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")        
      end
      it "商品説明が無記名では出品できない" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")         
      end
      it "商品がカテゴリーが選択されていなければ出品できない" do
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")   
      end
      it "商品の状態が選択されていなければ出品できない" do
        @item.condition_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1")   
      end
      it "配送料の負担が選択されていなければ出品できない" do
        @item.fee_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Fee must be other than 1")          
      end
      it "発送元の地域が選択されていなければ出品できない" do
        @item.prefecture_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")               
      end
      it "発送までの日数が選択されていなければ出品できない" do
        @item.waitingday_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Waitingday must be other than 1")            
      end
      it "価格が入力されていなければ出品できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")            
      end
      it "価格が300円未満では出品できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")            
      end
      it "価格が9,999,999円以上では出品できない" do
        @item.price = 99999999
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")            
      end
      it "価格が全角数字では出品できない" do
        @item.price = "９９９"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")            
      end
      it "価格が半角英数混合では出品できない" do
        @item.price = "1000dollars"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")            
      end
      it "価格が英語だけでは出品できない" do
        @item.price = "threehandreds"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")            
      end
      it "userが紐づいていないと出品できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")            
      end
    end
  end
end
