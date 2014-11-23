class Post < ActiveRecord::Base
  # Belongs to Topic
  belongs_to :topic, inverse_of: :posts

  # Self joins
  has_many    :sub_posts,    class_name: 'Post', foreign_key: 'parent_id', inverse_of: :parent_post
  belongs_to  :parent_post,  class_name: 'Post', foreign_key: 'parent_id', inverse_of: :sub_posts

  # chattable
  has_many    :messages, inverse_of: :chattable, as: :chattable
end
