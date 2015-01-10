class AddAllSubTopicIdsToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :all_sub_topic_ids, :text
  end
end
