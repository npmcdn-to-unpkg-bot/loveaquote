module SocialImageable
    extend ActiveSupport::Concern
    
    included do
        has_one :social_image, as: :source, dependent: :destroy
        after_save :generate_social_image
    end

    def generate_social_image
        if self.class.name == "Quote"
        else
            Delayed::Job.enqueue SocialImageJob.new(self.class.name, self.id)
        end
    end
end