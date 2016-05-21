class UserAddGeoipDataWorker
  include Sidekiq::Worker
  
  def perform(id, ip)
    user = User.find(id) 
    location = Geocoder.search(ip).first
    if location
        user.update_columns(
            city: location.city,
            state: location.state,
            state_code: location.state_code,
            country: location.country,
            country_code: location.country_code
        )
    end
  end
end