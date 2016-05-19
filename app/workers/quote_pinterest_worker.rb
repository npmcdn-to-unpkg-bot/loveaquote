class QuotePinterestWorker
    include Sidekiq::Worker

    def perform(id, ua)
        quote = Quote.find(id)
        quote.update_columnss(pinterest_share_count: quote.pinterest_share_count + 1)
        Log.create(source: quote, category: "Social Share", sub_category: "Pinterest", description: ua)
    end
end