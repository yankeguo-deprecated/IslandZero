class Topic < ActiveRecord::Base
  # Self joins
  has_many    :sub_topics,    class_name: 'Topic', foreign_key: 'parent_id', inverse_of: :parent_topic
  belongs_to  :parent_topic,  class_name: 'Topic', foreign_key: 'parent_id', inverse_of: :sub_topics

  # Has many Posts
  has_many    :posts, inverse_of: :topic

  # Has many relations with User
  has_many    :topic_users, inverse_of: :topic

  # Has many users
  has_many    :users, through: :topic_users

  # chattable
  has_many    :messages, inverse_of: :chattable, as: :chattable

  # Posts within this topic and subtopics
  def all_posts
    Post.where(topic_id: (self.all_sub_topic_ids_array | [ self.id ]), parent_id: 0)
  end

  def all_sub_topic_ids_array
    (self.all_sub_topic_ids || "").split(",").map { |id| id.to_i }
  end

  # Update all sub topic through recursive
  def update_all_sub_topic_ids
    ids = []
    Topic.find_all_sub_topic_ids self.id, ids
    self.all_sub_topic_ids = ids.compact.uniq.join(",")
    self.save
  end

  def update_all_parents_with_sub_topic_ids
    parent = self.parent_topic
    while parent.present? and parent.id != self.id do
      parent.update_all_sub_topic_ids
      parent = parent.parent_topic
    end
  end

  def self.find_all_sub_topic_ids(id, store)
    topic = Topic.find_by_id id
    if topic.present?
      ids = topic.sub_topic_ids
      ids.each do |sid|
        unless store.include?(sid)
          Topic.find_all_sub_topic_ids sid, store
        end
      end
      store.concat(ids)
    end
  end

  # Posts count after a time
  def posts_count_unvisited(user)
    topic_user = TopicUser.find_by(user: user, topic: self)
    if topic_user.present? and topic_user.visited_at.present?
      self.all_posts.where("created_at > ?", topic_user.visited_at).count
    else
      self.all_posts.count
    end
  end

  # Mark User as Visited
  def mark_visited(user)
    TopicUser.find_or_create_by(topic: self, user: user).update(visited_at: Time.current)
  end

  # Shortcut for Markdown parsed introduction

  def introduction_parsed
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    .render(self.introduction || "")
  end

  def introduction_plain
    Sanitize.clean(self.introduction_parsed, Sanitize::Config::STRICT)
  end

  # Helpers for stare
  def starring_users
    self.users.where("topic_users.is_starred" => true)
  end
end
