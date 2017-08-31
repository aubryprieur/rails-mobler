class ChargesController < ApplicationController
  skip_after_action :verify_authorized

  def new
  end

  def create
    @amount = params[:amount]
    @amount = @amount.gsub('€', '').gsub(',', '')
    begin
      @amount = Float(@amount).round(2)
    rescue
      flash[:error] = 'Charge not completed. Please enter a valid amount in EUR (€).'
      redirect_to new_charge_path
      return
    end

    @amount = (@amount * 100).to_i # Must be an integer!

    if @amount < 500
      flash[:error] = 'Charge not completed. Donation amount must be at least €5.'
      redirect_to new_charge_path
      return
    end

    Stripe::Charge.create(
      :amount => @amount,
      :currency => 'eur',
      :source => params[:stripeToken],
      :description => 'Custom donation'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
end
