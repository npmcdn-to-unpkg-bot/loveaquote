module Imageable
    extend ActiveSupport::Concern
    
    included do
        has_attached_file :image, 
            styles: { tiny: "50x50>", small: "100x100>", thumb: "150x150>", medium: "300x300>", large: "500x500>" },
            url: "/uploads/:class/:id/:slug_:style.:extension",
            path: ":rails_root/public:url"
            
        validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
        
        Paperclip.interpolates :slug  do |attachment, style|
            attachment.instance.slug
        end
    end
end