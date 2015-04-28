class AddPublishedToMediaItems < ActiveRecord::Migration
  def change
    add_column :media_items, :published, :boolean, default: false
  end
end
