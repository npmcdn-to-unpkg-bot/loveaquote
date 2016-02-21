json.array!(@authors) do |author|
  json.extract! author, :id, :name, :slug, :fetch_url, :published, :popular, :very_popular
  json.url author_url(author, format: :json)
end
