class AddVisitedAtToTopicUsers < ActiveRecord::Migration
  def change
    add_column :topic_users, :visited_at, :datetime, index: true
  end
end
