class RegenerateAllQuoteImagesWorker
    
    def perform
        Quote.where.not(image: '').find_each(batch_size: 100) do |quote|
            QuoteImageWorker.perform_async(quote.id)
            QuoteSocialImageWorker.perform_async(quote.id)
        end
    end
end