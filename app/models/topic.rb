class Topic < ActiveRecord::Base
  # Self joins
  has_many    :sub_topics,    class_name: 'Topic', foreign_key: 'parent_id', inverse_of: :parent_topic
  belongs_to  :parent_topic,  class_name: 'Topic', foreign_key: 'parent_id', inverse_of: :sub_topics

  # Has many Posts
  has_many    :posts, inverse_of: :topic

  # chattable
  has_many    :messages, inverse_of: :chattable, as: :chattable

  # Posts within this topic and subtopics
  def all_posts
    Post.where(topic_id: self.sub_topic_ids | [ self.id ])
  end

  # Shortcut for Markdown parsed introduction

  def introduction_parsed
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    .render(self.introduction || "")
  end

  def introduction_plain
    Sanitize.clean(self.introduction_parsed, Sanitize::Config::RESTRICTED)
  end
end
