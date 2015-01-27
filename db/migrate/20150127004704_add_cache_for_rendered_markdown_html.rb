class AddCacheForRenderedMarkdownHtml < ActiveRecord::Migration

  def change
    add_column :topics, :introduction_parsed, :text
    add_column :topics, :introduction_plain, :text

    add_column :posts,  :content_parsed, :text
    add_column :posts,  :content_plain,  :text
  end

end
