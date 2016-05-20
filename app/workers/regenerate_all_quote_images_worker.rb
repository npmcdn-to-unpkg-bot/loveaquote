class RegenerateAllQuoteImagesWorker
    include Sidekiq::Worker
    include ActionView::Helpers::TextHelper
    
    def perform
        Quote.find_each(batch_size: 100) do |quote|
            QuoteImageWorker.perform_async(quote.id)
        end
    end
end