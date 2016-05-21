class User < ActiveRecord::Base
  devise :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  
  def self.from_facebook(auth)
    user = User.where(email: auth.info.email).first_or_create
    identity = Identity.where(provider: auth.provider, uid: auth.uid, user_id: user.id).first_or_create
    UpdateFacebookIdentityWorker.perform_async(identity.id, auth)
    user
  end
  
  def self.from_google_oauth2(auth)
    user = User.where(email: auth.info.email).first_or_create
    identity = Identity.where(provider: auth.provider, uid: auth.uid, user_id: user.id).first_or_create
    UpdateGoogleIdentityWorker.perform_async(identity.id, auth)
    user    
  end
  
  has_many :identities, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :list_quotes, through: :lists

  scope :unread, -> {where(read: false)}
  
  after_create :create_default_list, :add_as_subscriber, :send_welcome_email
  
  def send_welcome_email
    UserMailer.welcome_email(self.id).deliver_now
  end
  
  def create_default_list
    List.create(name: "Default", user: self)
  end
  
  def add_as_subscriber
    Subscriber.create(email: self.email)
  end
  
  def name
    first_name = self.identities.order(updated_at: :asc).last.first_name || ""
    last_name = self.identities.order(updated_at: :asc).last.last_name || ""
    first_name + " " + last_name
  end
  
  def first_name
    self.identities.order(updated_at: :asc).last.first_name || ""
  end
  
  def region
    if self.city.present? && self.country.present?
      "#{self.city}, #{self.country}"
    else
      ""
    end
  end
  
  def image
    self.identities.order(updated_at: :asc).last.image || ""
  end
  
  def profile
    self.identities.order(updated_at: :asc).last.profile || "#"
  end
  
end