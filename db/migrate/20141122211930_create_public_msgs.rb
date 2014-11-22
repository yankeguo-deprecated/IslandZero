class CreatePublicMsgs < ActiveRecord::Migration
  def change
    create_table :public_msgs do |t|
      t.string :nickname, null: false
      t.text :content,    null: false

      t.timestamps
    end
  end
end
