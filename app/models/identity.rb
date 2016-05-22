class Identity < ActiveRecord::Base
    belongs_to :user
    
    def update_facebook_identity(auth)
        case auth["extra"]["raw_info"]["gender"]
        when "male"
          gender = "Male"
        when "female"
          gender = "Female"
        else
          gender = ""
        end
    
        self.update(
          first_name: auth["info"]["first_name"],
          last_name: auth["info"]["last_name"],
          image: auth["info"]["image"],    
          profile: auth["extra"]["raw_info"]["link"],
          gender: gender
        )            
    end
    
    def update_google_identity(auth)
        case auth["extra"]["raw_info"]["gender"]
        when "male"
          gender = "Male"
        when "female"
          gender = "Female"
        else
          gender = ""
        end
    
        self.update(
          first_name: auth["info"]["first_name"],
          last_name: auth["info"]["last_name"],
          image: auth["info"]["image"],    
          profile: auth["extra"]["raw_info"]["profile"],
          gender: gender
        )        
    end
end
