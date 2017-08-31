class PaymentsController < ApplicationController
  before_action :set_donation
  skip_after_action :verify_authorized

  def new
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @donation.amount_cents, # or amount_pennies
      description:  "Payment for donation",
      currency:     @donation.amount.currency
    )
    @wishlist = Wishlist.find(@donation.wishlist_id)
    redirect_to wishlist_path(@wishlist)

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_donation_payment_path(@donation)
  end

private

  def set_donation
    @donation = Donation.find(params[:donation_id])
  end
end
