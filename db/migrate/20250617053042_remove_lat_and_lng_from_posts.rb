class RemoveLatAndLngFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :lat, :float
    remove_column :posts, :lng, :float
  end
end
