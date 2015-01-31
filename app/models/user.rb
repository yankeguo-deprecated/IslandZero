require 'securerandom'

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
  has_many :posts, inverse_of: :user, dependent: :destroy

  # Messages
  has_many :messages, inverse_of: :user, dependent: :delete_all

  # Has many relations with Topic
  has_many    :topic_users, inverse_of: :user, dependent: :delete_all

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
      exists = User.find_by("#{provider}_uid" => auth.uid).present?
      if exists.present?
        exists
      else
        current_user.update "#{provider}_uid" => auth.uid
        current_user
      end
    else
      ouser = User.find_or_create_by("#{provider}_uid" => auth.uid) do |user|
        user.email    = "fake-#{provider}-#{auth.uid}@#{ENV['DOMAIN_NAME']}"
        user.password = SecureRandom.hex(10)
        user.is_email_fake    = true
        user.is_password_fake = true
        user.nickname = auth.info["name"] || "#{provider}#{auth.uid}"
      end
      ouser.confirm!
      ouser
    end
  end

  def revoke_oauth(provider)
    self.update("#{provider}_uid" => nil)
  end

  def has_oauth?(pvd = nil)
    if pvd.nil?
      self.class.omniauth_providers.any? do |provider|
        self.send(:"#{provider}_uid").present?
      end
    else
      self.send(:"#{pvd}_uid").present?
    end
  end

  def oauth_count
    self.class.omniauth_providers.count do |provider|
      self.send(:"#{provider}_uid").present?
    end
  end

end
