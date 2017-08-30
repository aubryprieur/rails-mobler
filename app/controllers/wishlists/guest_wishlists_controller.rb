
  class Wishlists::GuestWishlistsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_wishlist

    def create
      @guest_wishlist = @wishlist.guest_wishlists.new(guest_wishlist_params)
      @guest_wishlist.wishlist = @wishlist

      authorize @guest_wishlist

      if @guest_wishlist.save
        redirect_to @wishlist, notice: 'Saved!'
      else
        redirect_to @wishlist, alert: 'Failed saving!'
      end
    end

      private
      def set_wishlist
        @wishlist = current_user.wishlists.find(params[:wishlist_id])
      end

      def guest_wishlist_params
        params.require(:guest_wishlist).permit(:email)
      end

end
