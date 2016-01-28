json.array!(@quote_topic_suggestions) do |quote_topic_suggestion|
  json.extract! quote_topic_suggestion, :id
  json.url quote_topic_suggestion_url(quote_topic_suggestion, format: :json)
end
