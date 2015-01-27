class User < ActiveRecord::Base
  # :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable, :lockable, :timeoutable, :async, :omniauthable, :omniauth_providers => [ :google_oauth2, :twitter, :github ]

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

  # Topics
  has_many    :topics, through: :topic_users

  # Event
  has_many    :events, inverse_of: :user, dependent: :delete_all

  # Helpers for stare
  def starred_topics
    self.topics.where("topic_users.is_starred" => true)
  end

  # Super Admin is defined as id == 1
  def is_super_admin
    self.id == 1
  end

  # OmniAuth Methods
  def self.find_for_google_oauth2(auth)
    User.find_or_create_by(oauth_provider: auth.provider, oauth_uid: auth.uid) do |user|
      user.email    = auth.info["email"]
      user.password = Devise.friendly_token[0,20]

      user.nickname = auth.info["name"]
    end
  end

  def self.find_for_github(auth)
    User.find_or_create_by(oauth_provider: auth.provider, oauth_uid: auth.uid) do |user|
      user.email    = auth.info["email"]
      user.password = Devise.friendly_token[0,20]

      user.nickname = auth.info["name"]
    end
  end

  def self.find_for_twitter(auth)
    User.find_or_create_by(oauth_provider: auth.provider, oauth_uid: auth.uid) do |user|
      user.email    = "#{auth.provider}-#{auth.uid}@island0.com"
      user.password = Devise.friendly_token[0, 20]

      user.nickname = auth.info["name"]
    end
  end

end
