class Message < ActiveRecord::Base
  # Belongs to chattable
  belongs_to :chattable, polymorphic: true, inverse_of: :messages

  # Belongs to user
  belongs_to :user, inverse_of: :messages

  # Pushing
  after_create do
    hash = {
      user_id:        self.user.id,
      user_nickname:  self.user.nickname,
      content:        self.content,
      created_at:     self.created_at.to_s
    }
    RealtimeChatController.publish("/chat/#{self.chattable_type}/#{self.chattable_id}", hash)
    true
  end
end
