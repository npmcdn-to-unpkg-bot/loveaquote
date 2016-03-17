class SocialImage < ActiveRecord::Base
  belongs_to :source, polymorphic: true, touch: true
  
  mount_uploader :twitter, SocialImageUploader
  mount_uploader :facebook, SocialImageUploader
  mount_uploader :google_plus, SocialImageUploader
  mount_uploader :pinterest, SocialImageUploader
end
