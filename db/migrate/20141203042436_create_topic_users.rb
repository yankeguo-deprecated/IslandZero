class CreateTopicUsers < ActiveRecord::Migration
  def change
    create_table :topic_users do |t|
      t.integer :topic_id,  null: false, index: true
      t.integer :user_id,   null: false, index: true
      t.boolean :is_starred, null: false, default: false, index: true
    end

    add_index :topic_users, [:topic_id, :user_id], unique: true
  end
end
