class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      # Associations
      t.references  :chattable, polymorphic: true, index: true

      # Attributes
      t.text          :content, null: false
      t.belongs_to    :user,    null: false, index: true

      # Default
      t.timestamps
    end
  end
end
