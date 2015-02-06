module ApplicationHelper

  def li_link(link_text, link_path)
    content_tag(:li, class: ('active' if current_page?(link_path)) ) do
      link_to link_text, link_path
    end
  end

  def chatroom_meta_for(chattable)
    tag :meta, name: 'chatroom-channel', content: "/chat/#{chattable.class.to_s}/#{chattable.id}"
  end

  def user_meta_for(user)
    tag :meta, name: 'current-user-id', content: "#{user.id}"
  end

  def glyphicon(name)
    tag :span, class: "glyphicon glyphicon-#{name}", 'aria-hidden' => "true"
  end

end
