class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :item_purchases

  validates :password,        format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: /\A(?=.*?[ぁ-んァ-ン一-龥])[ぁ-んァ-ン一-龥]+\z/ }
    validates :first_name, format: { with: /\A(?=.*?[ぁ-んァ-ン一-龥])[ぁ-んァ-ン一-龥]+\z/ }
    validates :last_name_kana, format: { with: /\A(?=.*?[ァ-ンー－]+$)[ァ-ンー－]+$+\z/ }
    validates :first_name_kana, format: { with: /\A(?=.*?[ァ-ンー－]+$)[ァ-ンー－]+$+\z/ }
    validates :birthday
  end
end
