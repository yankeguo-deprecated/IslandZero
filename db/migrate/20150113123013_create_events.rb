class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id,     index: true, null: false
      t.string  :event_type,  index: true, null: false
      t.integer :count,                    null: false, default: 1
      t.integer :topic_id,    index: true, null: false, default: 0
      t.integer :post_id,     index: true, null: false, default: 0
      t.integer :sub_post_id, index: true, null: false, default: 0

      t.timestamps
    end
  end
end
