module SocialImageable
    extend ActiveSupport::Concern
    
    included do
        has_one :social_image, as: :source, dependent: :destroy
    end
end