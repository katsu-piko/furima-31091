require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいく場合' do
        it 'nickname,email,password,password_confirmation,ユーザー本名の名字と名前,ユーザー本名（カナ）の名字と名前,生年月日が存在すれば登録できる' do
          expect(@user).to be_valid
        end
        it 'passwordが6文字以上且、半角英数字混合であれば登録できる' do
          @user.password = 'abc123'
          @user.password_confirmation = 'abc123'
          expect(@user).to be_valid
        end
        it 'ユーザー本名が、全角（漢字・ひらがな・カタカナ）であれば登録できる' do
          @user.last_name = 'テスト'
          @user.first_name = 'たろう'
          expect(@user).to be_valid
        end
        it 'ユーザー本名（カナ）が、全角（カタカナ）であれば登録できる' do
          @user.last_name_kana = 'テスト'
          @user.first_name_kana = 'タロウ'
        end
      end

      context '新規登録がうまくいかない場合' do
        it 'nicknameが空だと登録できない' do
          @user.nickname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
        it 'emailが空だと登録できない' do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it '重複したemailが存在する場合登録できない' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end
        it 'emailに、@が含まれない場合登録できない' do
          @user.email = 'example.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end
        it 'passwordが空だと登録できない' do
          @user.password = nil
          @user.password_confirmation = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank", 'Password is invalid')
        end
        it 'passwordが5文字以下だと登録できない' do
          @user.password = '123ab'
          @user.password_confirmation = '123ab'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end
        it 'passwordが数字のみだと登録できない' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it 'passwordが英字のみだと登録できない' do
          @user.password = 'abcdef'
          @user.password_confirmation = 'abcdef'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it 'passwordが存在してもpassword_confirmationが空だと登録できない' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it 'ユーザー本名が空の場合登録できない' do
          @user.last_name = nil
          @user.first_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid', "First name can't be blank", 'First name is invalid')
        end
        it 'ユーザー本名が英字の場合登録できない' do
          @user.last_name = 'abc'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name is invalid')
        end
        it 'ユーザー本名の名字、名前のどちらかが空の場合登録できない' do
          @user.last_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
        end
        it 'ユーザー本名（カナ）が空だと登録できない' do
          @user.last_name_kana = nil
          @user.first_name_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana is invalid', "First name kana can't be blank", 'First name kana is invalid')
        end
        it 'ユーザー本名（カナ）が漢字の場合登録できない' do
          @user.last_name_kana = '山田'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana is invalid')
        end
        it 'ユーザー本名（カナ）がひらがなの場合登録できない' do
          @user.last_name_kana = 'やまだ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana is invalid')
        end
        it 'ユーザー本名（カナ）が英字の場合登録できない' do
          @user.last_name_kana = 'yamada'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana is invalid')
        end
        it 'ユーザー本名（カナ）の名字、名前のどちらかが空の場合登録できない' do
          @user.last_name_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana is invalid')
        end
        it '生年月日が空だと登録できない' do
          @user.birthday = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end
      end
    end
  end
end
