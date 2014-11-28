class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      # Associations
      t.integer     :parent_id, null: false, default: 0, index: true

      # Attributes
      t.string  :title,         null: false
      t.text    :introduction,  null: false
      t.integer :rank,          null: false, default: 100, index: true

      # Default
      t.timestamps
    end
  end
end
