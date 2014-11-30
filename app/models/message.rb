class Message < ActiveRecord::Base
  # Include DataHelper so we can use time_ago_in_words
  include ActionView::Helpers::DateHelper

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
      created_at:     time_ago_in_words(self.created_at)
    }
    RealtimeChatController.publish("/chat/#{self.chattable_type}/#{self.chattable_id}", hash)
    true
  end
end
