class Message < ActiveRecord::Base
  # Belongs to chattable
  belongs_to :chattable, polymorphic: true, inverse_of: :messages

  # Belongs to user
  belongs_to :user, inverse_of: :messages
end
