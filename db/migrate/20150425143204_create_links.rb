class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :type    
      t.string :url    
      t.integer :media_item_id

      t.timestamps null: false
    end
  end
end
