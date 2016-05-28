class RegenerateAllQuoteImagesWorker
    include Sidekiq::Worker
    
    def perform
        SocialImage.find_each(batch_size: 100) do |si|
            si.source.generate_social_image
            sleep(5)
        end
    end
end