module ApplicationHelper

  def li_link(link_text, link_path, &block)
    if link_text.nil?
      content_tag(:li, class: ('active' if current_page?(link_path)) ) do
        link_to link_path, &block
      end
    else
      content_tag(:li, class: ('active' if current_page?(link_path)) ) do
        link_to link_text, link_path
      end
    end
  end

  def chatroom_meta_for(chattable)
    tag :meta, name: 'chatroom-channel', content: "/chat/#{chattable.class.to_s}/#{chattable.id}"
  end

  def user_meta_for(user)
    tag :meta, name: 'current-user-id', content: "#{user.id}"
  end

  def glyphicon(name)
    "<span class=\"glyphicon glyphicon-#{name}\" aria-hidden=\"true\"></span>".html_safe
  end

end
