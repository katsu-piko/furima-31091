class ItemPurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item_id, only: [:index, :create]

  def index
    redirect_to root_path if current_user.id == @item.user_id || ItemPurchase.exists?(item_id: @item)
    @buy_user = BuyUser.new
  end

  def create
    @buy_user = BuyUser.new(buy_params)
    if @buy_user.valid?
      pay_item
      @buy_user.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def buy_params
    params.require(:buy_user).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item[:price],
      card: buy_params[:token],
      currency: 'jpy'
    )
  end

  def set_item_id
    @item = Item.find(params[:item_id])
  end

end
