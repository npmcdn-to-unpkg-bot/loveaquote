class QuoteGooglePlusWorker < Struct.new(:id, :ua)
    def perform(id, ua)
        quote = Quote.find(id)
        quote.update_columns(google_plus_share_count: quote.google_plus_share_count + 1)
        Log.create(source: quote, category: "Social Share", sub_category: "Google Plus", description: ua)
    end
end