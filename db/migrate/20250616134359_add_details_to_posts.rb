class AddDetailsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :lat, :float
    add_column :posts, :lng, :float
  end
end
