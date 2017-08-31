class OrdersController < ApplicationController
  def show
    @order = Order.where(state: 'paid').find(params[:id])
    authorize @order
  end

  def create
    @wishlist = Wishlist.find(params[:wishlist_id])
    order = Order.create!(amount: @furniture.price, state: 'pending')
    authorize order
    redirect_to new_order_payment_path(order)
  end


end
