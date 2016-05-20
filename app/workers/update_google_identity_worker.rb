class UpdateGoogleIdentityWorker
  include Sidekiq::Worker

  def perform(id, auth)
    identity = Identity.find(id)

    case auth["extra"]["raw_info"]["gender"]
    when "male"
      gender = "Male"
    when "female"
      gender = "Female"
    else
      gender = ""
    end
    
    identity.first_name = auth["info"]["first_name"]
    identity.last_name = auth["info"]["last_name"]
    identity.image = auth["info"]["image"]
    identity.profile = auth["extra"]["raw_info"]["profile"]
    identity.gender = gender
    
    identity.save
  end
end