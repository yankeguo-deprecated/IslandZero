module ApplicationHelper

  def li_link(link_text, link_path)
    content_tag(:li, class: ('active' if current_page?(link_path)) ) do
      link_to link_text, link_path
    end
  end

  def chatroom_meta_tag
    tag :meta, name: 'chatroom-id', content: request.path
  end

  def glyphicon(name)
    tag :span, class: "glyphicon glyphicon-#{name}", 'aria-hidden' => "true"
  end

end
