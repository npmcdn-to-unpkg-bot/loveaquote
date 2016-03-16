module SocialImageable
    extend ActiveSupport::Concern
    
    included do
        has_one :social_image, as: :source, dependent: :destroy
        after_save :generate_social_image
    end
    
    def generate_social_image
        SocialImageWorker.perform_async(self.class.name, self.id)
    end
end