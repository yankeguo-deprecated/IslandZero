class Event < ActiveRecord::Base
  module Type
    # topic_id, post_id
    NewPost     = "new_post"
    # topic_id, post_id, sub_post_id
    NewSubPost  = "new_sub_post"
  end

  belongs_to :user, inverse_of: :events
  belongs_to :topic,inverse_of: :events
  belongs_to :post, inverse_of: :events
  belongs_to :sub_post, class_name: :Post, inverse_of: :events
end
