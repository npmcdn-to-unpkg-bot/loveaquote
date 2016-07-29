class QuoteFacebookJob < Struct.new(:id, :ua)
    def perform(id, ua)
        quote = Quote.find(id)
        quote.update_columns(facebook_share_count: quote.facebook_share_count + 1)
        Log.create(source: quote, category: "Social Share", sub_category: "Facebook", description: ua)
    end
end