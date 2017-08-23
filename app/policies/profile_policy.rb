class ProfilePolicy < Struct.new(:user, :profile)

  def profile?
    !user.nil?
  end
end
