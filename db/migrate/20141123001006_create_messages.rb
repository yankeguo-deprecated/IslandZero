class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content, null: false
      t.belongs_to :topic, index: true, null: false, default: 0

      t.timestamps
    end
  end
end
