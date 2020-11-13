class BuyUser
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/}
  end

  def save
    item_purchase = ItemPurchase.create(user_id: current_user.id, item_id: @item.id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture, city: city, address: address, building: building, item_purchase_id: item_purchase.id)
  end
end