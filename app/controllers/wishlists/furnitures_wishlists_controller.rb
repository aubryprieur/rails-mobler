class FurnituresWishlistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :destroy]

  def show

  end
end
