json.array!(@books) do |book|
  json.extract! book, :id, :name, :slug, :published, :popular, :very_popular, :references
  json.url book_url(book, format: :json)
end
