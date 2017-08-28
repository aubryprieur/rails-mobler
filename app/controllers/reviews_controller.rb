class ReviewsController < ApplicationController

  # def index
  #   @reviews = policy_scope(Review).where(furnitures_wishlist: @furniture)
  # end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    furnitures_wishlist = @review.furnitures_wishlist
    @wishlist = furnitures_wishlist.wishlist
    authorize @review
    if @review.save
      redirect_to wishlist_path(@wishlist)
    else
      redirect_to root_path
    end
  end

private

  def review_params
    params.require(:review).permit(:content, :furnitures_wishlist_id)
  end
end

