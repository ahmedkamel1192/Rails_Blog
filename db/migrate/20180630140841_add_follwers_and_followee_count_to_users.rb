class AddFollwersAndFolloweeCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users ,:count_followers ,:integer, :default=> 0
    add_column :users ,:count_followees ,:integer, :default=> 0
  end
end
