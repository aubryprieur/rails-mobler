class CreateFurnitures < ActiveRecord::Migration[5.1]
  def change
    create_table :furnitures do |t|
      t.string :title
      t.text :description
      t.string :photo
      t.string :height
      t.string :width
      t.string :length
      t.string :price
      t.string :url
      t.references :category, foreign_key: true
      t.references :review, foreign_key: true

      t.timestamps
    end
  end
end
