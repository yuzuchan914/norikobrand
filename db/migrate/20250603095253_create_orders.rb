class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.text :message
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
