class AddEmailToGuestWishlists < ActiveRecord::Migration[5.1]
  def change
    add_column :guest_wishlists, :email, :string
  end
end
