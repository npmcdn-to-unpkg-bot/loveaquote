class User < ActiveRecord::Base
  devise :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  
  def self.from_facebook(auth)
    user = User.where(email: auth.info.email).first_or_create
    identity = Identity.where(provider: auth.provider, uid: auth.uid, user_id: user.id).first_or_create
    identity.update_facebook_identity(auth)
    user
  end
  
  def self.from_google_oauth2(auth)
    user = User.where(email: auth.info.email).first_or_create
    identity = Identity.where(provider: auth.provider, uid: auth.uid, user_id: user.id).first_or_create
    identity.update_google_identity(auth)
    user    
  end
  
  has_many :identities, dependent: :destroy
  has_many :user_lists, dependent: :destroy
  has_many :user_quotes, dependent: :destroy

  scope :unread, -> {where(read: false)}
  
  after_create :create_default_list, :send_welcome_email
  
  def send_welcome_email
    UserMailer.delay.welcome_email(self.id) if Rails.env.production?
  end
  
  def create_default_list
    UserList.create(name: "Default", user: self)
  end
  
  def name
    first_name = self.identities.order(updated_at: :asc).last.first_name || ""
    last_name = self.identities.order(updated_at: :asc).last.last_name || ""
    first_name + " " + last_name
  end
  
  def first_name
    self.identities.order(updated_at: :asc).last.first_name || ""
  end
  
  def last_name
    self.identities.order(updated_at: :asc).last.last_name || ""
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
  
  def marked_for_deletion
    self.mark_for_deletion ? true : false
  end
  
  def user_quotes_array
    self.user_quotes.pluck(:quote_id)
  end
end