class AddCountToFavourites < ActiveRecord::Migration[5.2]
  def change
    add_column :articles ,:count,:integer , :default => 0
  end
end
