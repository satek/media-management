class CreateMediaItems < ActiveRecord::Migration
  def change
    create_table :media_items do |t|
      t.string :type
      t.string :title
      t.string :description

      t.timestamps null: false
    end
  end
end
