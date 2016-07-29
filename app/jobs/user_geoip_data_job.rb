class UserGeoipDataJob < Struct.new(:id, :ip)

  def perform
    user = User.find(id)
    if user.city.blank? || user.last_sign_in_ip.to_s !=  ip
      location = Geocoder.search(ip).first
      if location
          user.update_columns(
              city: location.data["city"],
              state: location.data["region_name"],
              state_code: location.data["region_code"],
              country: location.data["country_name"],
              country_code: location.data["country_code"],
              time_zone: location.data["time_zone"],
              latitude: location.data["latitude"],
              longitude: location.data["longitude"]
          )
      end
    end
  end
end