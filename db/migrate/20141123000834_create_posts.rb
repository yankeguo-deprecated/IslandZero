class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.belongs_to :topic, index: true, null: false, defaul: 0

      t.timestamps
    end
  end
end
