class AddIndexToFollowerAndFollowedUserInFollows < ActiveRecord::Migration[7.0]
  def up
    add_index :follows, [:follower_id, :followed_user_id], unique: true
  end

  def down
    remove_index :follows, [:follower_id, :followed_user_id]
  end
end
