class QuoteGooglePlusWorker
    include Sidekiq::Worker

    def perform(id, ua)
        quote = Quote.find(id)
        quote.update(
            google_plus_share_count: quote.google_plus_share_count + 1,
            total_share_count: quote.total_share_count + 1
        )
        Log.create(source: quote, category: "Social Share", sub_category: "Google Plus", description: ua)
    end
end