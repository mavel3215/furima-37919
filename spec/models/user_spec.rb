require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nicknameとemail,password,password_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    
    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email =""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複するemailが存在する場合は登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailは@を含まないと登録できない" do
        @user.email = "testmail"
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが6文字未満では空では登録できない" do
        @user.password = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end      
      it "passwordが英語のみでは登録できない" do
        @user.password ="abcdef"
        @user.password_confirmation ="abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      it "passwordが数字のみでは登録できない" do
        @user.password ="123456"
        @user.password_confirmation ="123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      
      it "passwordが全角英数字混合では登録できない" do
        @user.password ="１２３ ABC"
        @user.password_confirmation ="１２３ ABC"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password ="123456"
        @user.password_confirmation ="1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "名字がなければ登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "名前がなければ登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "名字カナがなければ登録できない" do
        @user.last_name_katakana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana can't be blank")
      end
      it "名前カナがなければ登録できない" do
        @user.first_name_katakana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana can't be blank")
      end

      it "名字が全角(漢字・ひらがな・カタカナ)でないと登録できない" do
        @user.last_name = "katou"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
      end
      it "名前が全角(漢字・ひらがな・カタカナ)でないと登録できない" do
          @user.first_name = "sakichi"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")       
      end
      it "名字(カナ)が全角(カナ)でないと登録できない" do
        @user.last_name_katakana = "katou"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana はカタカナで入力して下さい。")
      end
      it "名前(カナ)が全角(カナ)でないと登録できない" do
        @user.first_name_katakana = "sakichi"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana はカタカナで入力して下さい。")        
      end

      it "生年月日が空では登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")   
      end
    end
  end
end


