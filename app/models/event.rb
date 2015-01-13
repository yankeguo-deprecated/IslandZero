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

  def self.create_for_new_post(post)
    topic = post.topic
    return if topic.nil?
    topic.starring_users.each do |u|
      u.events.create(event_type: Event::Type::NewPost, topic_id: topic.id, post_id: post.id)
    end
  end

  def self.create_for_new_sub_post(sub_post)
    post = sub_post.parent_post
    return if post.nil?
    topic= post.topic
    return if topic.nil?
    uids = Post.where(parent_id: post.id).select(:user_id).uniq.map do |sp|
      sp.user_id
    end
    unless uids.include? post.user_id
      uids << post.user_id
    end
    uids.compact.uniq.each do |uid|
      user = User.find_by_id uid
      if user.present?
        if user.id == sub_post.id
          user.events.create(event_type: Event::Type::NewSubPost, topic_id: topic.id, post_id: post.id, sub_post_id: sub_post_id)
        else
          last = user.events.last
          if last.event_type == Event::Type::NewSubPost and last.post_id == post.id
            last.update(count: last.count + 1)
          else
            user.events.create(event_type: Event::Type::NewSubPost, topic_id: topic.id, post_id: post.id, sub_post_id: sub_post_id)
          end
        end
      end
    end
  end

end
