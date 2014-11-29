class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      # Associations
      t.belongs_to  :topic,     null: false, index: true
      t.belongs_to  :user,      null: false, index: true
      t.integer     :parent_id, null: false, default: 0, index: true

      # Attributes
      t.string      :title
      t.text        :content,   null: false

      # Default
      t.timestamps
    end
  end
end
