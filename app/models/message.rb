class Message < ActiveRecord::Base
  # Belongs to chattable
  belongs_to :chattable, polymorphic: true, inverse_of: :messages
end
