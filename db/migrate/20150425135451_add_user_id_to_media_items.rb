class AddUserIdToMediaItems < ActiveRecord::Migration
  def change
    add_column :media_items, :user_id, :integer
  end
end
