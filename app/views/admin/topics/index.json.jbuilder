json.array!(@topics) do |topic|
  json.extract! topic, :id, :name, :slug, :popular, :very_popular, :published
  json.url topic_url(topic, format: :json)
end
