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

  def self.find_for_oauth(provider, auth, current_user = nil)
    if current_user
      current_user.update "#{provider}_uid" => auth.uid
      current_user
    else
      ouser = User.find_or_create_by("#{provider}_uid" => auth.uid) do |user|
        user.email    = "fake-#{provider}-#{auth.uid}@#{ENV['DOMAIN_NAME']}"
        user.nickname = auth.info["name"] || "#{provider}#{auth.uid}"
      end
      ouser.confirm!
      ouser
    end
  end

  def has_oauth?
    self.twitter_uid.present? or self.github_uid.present? or google_oauth2_uid.present?
  end

end
