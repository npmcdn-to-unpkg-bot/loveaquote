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
  
  has_many :identities, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :list_quotes, through: :lists

  scope :unread, -> {where(read: false)}
  
  after_create :create_default_list
  
  def create_default_list
    List.create(name: "Default", user: self)
  end
end
