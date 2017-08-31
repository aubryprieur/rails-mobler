class CreateDonations < ActiveRecord::Migration[5.1]
  def change
    create_table :donations do |t|
      t.monetize :amount, currency: { present: false }
      t.references :wishlist, foreign_key: true

      t.timestamps
    end
  end
end
