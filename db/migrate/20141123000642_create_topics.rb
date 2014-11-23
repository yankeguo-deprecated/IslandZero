class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title,  null: false
      t.text :introduction, null: false

      t.timestamps
    end
  end
end
