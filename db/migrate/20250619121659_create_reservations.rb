class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.datetime :datetime
      t.text :note

      t.timestamps
    end
  end
end
