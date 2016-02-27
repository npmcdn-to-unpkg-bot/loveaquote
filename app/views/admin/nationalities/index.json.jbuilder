json.array!(@nationalities) do |nationality|
  json.extract! nationality, :id, :name
  json.url nationality_url(nationality, format: :json)
end
