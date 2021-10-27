class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.references :author, index: true
      t.references :category, index: true
      t.string :title
      t.text :description
      t.string :isbn
      t.string :image_link
      t.timestamps
    end
  end
end
