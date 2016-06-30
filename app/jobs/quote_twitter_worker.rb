class QuoteTwitterWorker

    def perform(id, ua)
        quote = Quote.find(id)
        quote.update_columns(twitter_share_count: quote.twitter_share_count + 1)
        Log.create(source: quote, category: "Social Share", sub_category: "Twitter", description: ua)
    end
end