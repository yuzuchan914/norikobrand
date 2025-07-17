class CreateVisions < ActiveRecord::Migration[7.1]
  def change
    create_table :visions do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
