class SubscriberGeoipDataWorker
  include Sidekiq::Worker
  
  def perform(id, ip)
    subscriber = Subscriber.find(id)
    time_zone = ""
    location = Geocoder.search(ip).first
    if location
        time_zone = location.data["time_zone"]
    end
    subscriber.update_columns(time_zone: time_zone)
  end
end