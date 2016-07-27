class SocialImage < ActiveRecord::Base
  belongs_to :source, polymorphic: true

  has_attached_file :facebook, 
      url: "/uploads/:class/:id/:slug.:extension",
      path: ":rails_root/public:url"
  has_attached_file :twitter, 
      url: "/uploads/:class/:id/:slug.:extension",
      path: ":rails_root/public:url"
  has_attached_file :pinterest, 
      url: "/uploads/:class/:id/:slug.:extension",
      path: ":rails_root/public:url"
  has_attached_file :google_plus, 
      url: "/uploads/:class/:id/:slug.:extension",
      path: ":rails_root/public:url"      
      
  validates_attachment_content_type :facebook, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :twitter, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :pinterest, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :google_plus, content_type: /\Aimage\/.*\Z/
  
  Paperclip.interpolates :slug  do |attachment, style|
      attachment.instance.source.slug
  end
end
