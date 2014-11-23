class AddParentIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :parent_id, :integer, null: false, default: 0, index: true
  end
end
