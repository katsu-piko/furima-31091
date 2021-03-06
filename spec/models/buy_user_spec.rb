require 'rails_helper'

RSpec.describe BuyUser, type: :model do
  before do
    @buy_user = FactoryBot.build(:buy_user)
  end
  describe '購入情報の保存' do
    context '購入情報が保存できる場合' do
      it '郵便番号、都道府県、市区町村、番地、建物、電話番号、カード情報が正しく入力されていれば保存できる' do
        expect(@buy_user).to be_valid
      end
      it '建物が空でも保存できる' do
        @buy_user.building = nil
        expect(@buy_user).to be_valid
      end
    end
    context '購入情報が保存できない場合' do
      it '郵便番号が空だと保存できないこと' do
        @buy_user.postal_code = nil
        @buy_user.valid?
        expect(@buy_user.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid')
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @buy_user.postal_code = 1234567
        @buy_user.valid?
        expect(@buy_user.errors.full_messages).to include('Postal code is invalid')
      end
      it '都道府県が1の時は保存できないこと' do
        @buy_user.prefecture_id = 1
        @buy_user.valid?
        expect(@buy_user.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '都道府県が空の時は保存できないこと' do
        @buy_user.prefecture_id = nil
        @buy_user.valid?
        expect(@buy_user.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @buy_user.city = nil
        @buy_user.valid?
        expect(@buy_user.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @buy_user.address = nil
        @buy_user.valid?
        expect(@buy_user.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @buy_user.phone_number = nil
        @buy_user.valid?
        expect(@buy_user.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid')
      end
      it '電話番号にハイフンが含まれると保存できないこと' do
        @buy_user.phone_number = '090-0000-0000'
        @buy_user.valid?
        expect(@buy_user.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が11桁以上だと保存できないこと' do
        @buy_user.phone_number = '090123456789'
        @buy_user.valid?
        expect(@buy_user.errors.full_messages).to include('Phone number is invalid')
      end
      it 'カード情報が正しく入力されていないと(tokenが空だと)保存できないこと' do
        @buy_user.token = nil
        @buy_user.valid?
        expect(@buy_user.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
