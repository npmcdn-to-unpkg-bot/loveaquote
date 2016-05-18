class User < ActiveRecord::Base
  devise :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  
  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first_or_create
    Identity.where(provider: auth.provider, uid: auth.uid).first_or_create do |identity|
      identity.user = user
    end
    user
  end
  
  has_many :my_quotes, dependent: :destroy
  has_many :identities, dependent: :destroy
  
  scope :unread, -> {where(read: false)}
end
