json.array!(@topics) do |topic|
  json.extract! topic, :id, :title, :introduction
  json.url topic_url(topic, format: :json)
end
