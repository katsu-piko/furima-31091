require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいく場合' do
        it "nickname,email,password,password_confirmation,ユーザー本名の名字と名前,ユーザー本名（カナ）の名字と名前,生年月日が存在すれば登録できる" do
        end
        it "passwordが6文字以上且、半角英数字混合であれば登録できる" do
        end
        it "ユーザー本名が、全角（漢字・ひらがな・カタカナ）であれば登録できる" do
        end
        it "ユーザー本名（カナ）が、全角（カタカナ）であれば登録できる" do
        end
      end

      context '新規登録がうまくいかない場合' do
        it "nicknameが空だと登録できない" do
        end
        it "emailが空だと登録できない" do
        end
        it "重複したemailが存在する場合登録できない" do
        end
        it "emailに、@が含まれない場合登録できない" do
        end
        it "passwordが空だと登録できない" do
        end
        it "passwordが5文字以下だと登録できない" do
        end
        it "passwordが数字のみだと登録できない" do
        end
        it "passwordが英字のみだと登録できない" do
        end
        it "ユーザー本名が空の場合登録できない" do
        end
        it "ユーザー本名が英字の場合登録できない" do
        end
        it "ユーザー本名（カナ）が空だと登録できない" do
        end
        it "ユーザー本名（カナ）が漢字の場合登録できない" do
        end
        it "ユーザー本名（カナ）がひらがなの場合登録できない" do
        end
        it "ユーザー本名（カナ）が英字の場合登録できない" do
        end 
        it "生年月日が空だと登録できない" do
        end
      end
    end
  end
end
