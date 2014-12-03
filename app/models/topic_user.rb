class TopicUser < ActiveRecord::Base
  belongs_to :user, inverse_of: :topic_users
  belongs_to :topic, inverse_of: :topic_users
end
