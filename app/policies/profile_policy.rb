class ProfilePolicy < Struct.new(:user, :profile)

  def profile?
    !user.nil?
  end

  def delete_wishlist?
    true
  end
end
