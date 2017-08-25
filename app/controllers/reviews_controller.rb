class ReviewsController < ApplicationController


  def create
    @furniture = Furniture.find(params[:furniture_id])
    @review = Review.new(review_params)
    @review.furniture = Furniture.find(params[:furniture_id])
  end
end
