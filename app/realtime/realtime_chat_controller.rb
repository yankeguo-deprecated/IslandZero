require 'sanitize'

class RealtimeChatController < FayeRails::Controller

  # Filter clean nickname/content
  channel '/chat/public' do
    filter :in do
      if data?
        data['content'] = Sanitize.clean(data['content'], Sanitize::Config::RESTRICTED)
        data['nickname'] = Sanitize.clean(data['nickname'], Sanitize::Config::RESTRICTED)
        modify message
      else
        pass
      end
    end
  end

  # Create Model
  channel '/chat/public' do
    monitor :publish do
      PublicMsg.create nickname: data['nickname'], content: data['content']
    end
  end
end
