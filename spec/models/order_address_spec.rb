require 'rails_helper'

RSpec.describe OrderAddress, type: :model do

  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe "商品購入" do
    context "商品購入できる場合" do
      it "必要な情報を適切に入力して「購入する」ボタンを押すと、購入情報がデータベースに保存される" do
        expect(@order_address).to be_valid
      end
      it "建物名がなくても購入できる" do
        @order_address.building_name=""
        @order_address.valid?
      end
    end
  
    context "商品購入できない場合" do
      it "郵便番号がなければ購入できない" do
        @order_address.post_code =""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it "郵便番号が3桁ハイフン4桁でなければ購入できない" do
        @order_address.post_code ="1111111"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code input correctly")        
      end
      it "郵便番号が半角文字でなければ購入できない" do
        @order_address.post_code ="１１１ー１１１１"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code input correctly")        
      end
      it "都道府県がなければ購入できない" do
        @order_address.prefecture_id =""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture select")
      end
      it "市区町村がなければ購入できない" do
        @order_address.address1 =""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address1 can't be blank")        
      end
      it "番地がなければ購入できない" do
        @order_address.address2 =""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address2 can't be blank")            
      end
      it "電話番号がなければ購入できない" do
        @order_address.phone_number =""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")            
      end
      it "電話番号が10桁以上11桁以内の半角数値でなければ購入できない" do
        @order_address.phone_number ="111111111"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid.")            
      end
      it "tokenが空では購入できない" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

    end
  end  
end
