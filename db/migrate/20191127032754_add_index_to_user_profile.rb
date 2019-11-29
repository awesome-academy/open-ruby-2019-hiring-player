class AddIndexToUserProfile < ActiveRecord::Migration[6.0]
  def change
    add_index :user_profiles, :user_id, unique: true
  end
end
