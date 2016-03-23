namespace :quote_share_count do
    task :correct => :environment do
        Log.where(category: "Social Share").each do |log|
            case log.sub_category
            when "Twitter"
                quote = Quote.find(log.source_id)
                quote.update_columns(twitter_share_count: quote.twitter_share_count - 1, total_share_count: quote.total_share_count - 1)
                log.destroy

            when "Facebook"
                quote = Quote.find(log.source_id)
                quote.update_columns(facebook_share_count: quote.facebook_share_count - 1, total_share_count: quote.total_share_count - 1)
                log.destroy

            when "Pinterest"
                quote = Quote.find(log.source_id)
                quote.update_columns(pinterest_share_count: quote.pinterest_share_count - 1, total_share_count: quote.total_share_count - 1)
                log.destroy

            when "Google Plus"
                quote = Quote.find(log.source_id)
                quote.update_columns(google_plus_share_count: quote.google_plus_share_count - 1, total_share_count: quote.total_share_count - 1)
                log.destroy
            end
        end
    end
end