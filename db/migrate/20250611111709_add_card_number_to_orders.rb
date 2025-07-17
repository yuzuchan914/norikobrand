class AddCardNumberToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :card_number, :string
  end
end