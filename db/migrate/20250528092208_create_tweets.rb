class CreateTweets < ActiveRecord::Migration[7.1]
  def change
    create_table :tweets do |t|
      t.string :title
      t.text :body
      t.string :name
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end
