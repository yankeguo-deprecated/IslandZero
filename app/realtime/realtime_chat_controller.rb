class RealtimeChatController < FayeRails::Controller
  channel '/chat/public' do
    monitor :subscribe do
      puts "Client #{client_id} subscribed to #{channel}."
    end
    monitor :unsubscribe do
      puts "Client #{client_id} unsubscribed from #{channel}."
    end
    monitor :publish do
      puts "Client #{client_id} published #{data} to #{channel}."
      PublicMsg.create nickname: data['nickname'], content: data['content']
    end
  end
end
