class User < ActiveRecord::Base
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :async

  before_save do
    self.nickname = self.email.split('@').first if self.nickname.nil?
  end
end
