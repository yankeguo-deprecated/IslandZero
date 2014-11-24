module ApplicationHelper

  def li_link(link_text, link_path)
    content_tag(:li, class: ('active' if current_page?(link_path)) ) do
      link_to link_text, link_path
    end
  end

  def chatbox_meta_tag
    tag :meta, name: 'chatbox-room', content: 'test_content'
  end

end
