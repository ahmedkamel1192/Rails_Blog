class AddFollowersId < ActiveRecord::Migration[5.2]
  def change
    add_column :follows ,:follower_id ,:integer
    add_column :follows ,:followee_id ,:integer

  end
end
