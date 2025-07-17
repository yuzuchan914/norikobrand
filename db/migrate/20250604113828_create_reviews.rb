class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true
      t.text :comment
      t.integer :rating
      t.string :image

      t.timestamps
    end
  end
end
