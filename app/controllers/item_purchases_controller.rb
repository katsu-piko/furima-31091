class ItemPurchasesController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @buy_user = BuyUser.new
  end

  def create
    @buy_user = BuyUser.new(buy_params)
    if @buy_user.valid?
      @buy_user.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def buy_params
    params.require(:buy_user).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
