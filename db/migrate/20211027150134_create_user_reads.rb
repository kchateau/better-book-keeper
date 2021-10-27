class CreateUserReads < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reads do |t|
      t.references :user, index: true
      t.references :book, index: true
      t.integer :rating
      t.timestamps
    end
  end
end
