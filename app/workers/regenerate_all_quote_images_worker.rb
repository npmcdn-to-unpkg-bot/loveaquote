class RegenerateAllQuoteImagesWorker
    include Sidekiq::Worker
    include ActionView::Helpers::TextHelper
    
    def perform
        Quote.where.not(image: '').find_each(batch_size: 100) do |quote|
            QuoteImageWorker.perform_async(quote.id)
            sleep(5)
        end
    end
end