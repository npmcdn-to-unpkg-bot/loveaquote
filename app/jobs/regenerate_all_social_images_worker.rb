class RegenerateAllSocialImagesWorker

    def perform
        SocialImage.find_each(batch_size: 100) do |si|
            si.source.generate_social_image
        end
    end
end