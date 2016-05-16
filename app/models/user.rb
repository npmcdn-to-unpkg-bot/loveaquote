class User < ActiveRecord::Base
  devise :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
    end
  end
  
  has_many :my_quotes, dependent: :destroy
end
