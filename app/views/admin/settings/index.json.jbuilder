json.array!(@settings) do |setting|
  json.extract! setting, :id, :google_analytics, :bing_verification, :alexa_verification, :google_verification, :yandex_verification
  json.url setting_url(setting, format: :json)
end
