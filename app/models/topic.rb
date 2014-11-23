class Topic < ActiveRecord::Base
  has_many    :sub_topics,    class_name: 'Topic', foreign_key: 'parent_id', inverse_of: :parent_topic
  belongs_to  :parent_topic,  class_name: 'Topic', foreign_key: 'parent_id', inverse_of: :sub_topics
end
