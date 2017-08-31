class DonationsController < ApplicationController
  def show
    @donation = Donation.find(params[:wishlist_id])
    authorize @donation
  end

  def create
    @wishlist = Wishlist.find(params[:wishlist_id])
    donation = Donation.new(amount: params[:amount])
    donation.wishlist_id = @wishlist.id
    donation.user_id = current_user.id
    donation.save
    authorize donation
    redirect_to  new_donation_payment_path(donation)
  end

end
