class User < ActiveRecord::Base
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :async

  before_save do
    self.is_admin = true if User.count == 0
    self.nickname = self.email.split('@').first if self.nickname.nil?
    true
  end

  # Posts
  has_many :posts, inverse_of: :user

  # Messages
  has_many :messages, inverse_of: :user

  # Has many relations with Topic
  has_many    :topic_users, inverse_of: :user

  has_many    :topics, through: :topic_users

  # Helpers for stare
  def starred_topics
    self.topics.where("topic_users.is_starred" => true)
  end
end
