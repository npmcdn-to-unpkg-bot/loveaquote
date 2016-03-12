json.array!(@user_searches) do |user_search|
  json.extract! user_search, :id, :text, :source_id
  json.url user_search_url(user_search, format: :json)
end
