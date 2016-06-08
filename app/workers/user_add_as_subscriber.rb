class UserAddAsSubscriber
    include Sidekiq::Worker
    
    def perform(id, ip)
        user = User.find(id)
        subscriber = Subscriber.where(email: user.email).first_or_create
        time_zone = ""
        location = Geocoder.search(ip).first        
        if location
            time_zone = location.data["time_zone"]
        end
        subscriber.update_columns(
            first_name: user.first_name,
            last_name: user.last_name,
            time_zone: time_zone
        )
    end
end