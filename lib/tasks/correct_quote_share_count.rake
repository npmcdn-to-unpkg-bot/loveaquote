namespace :quote_share_count do
    task :correct => :environment do 

        Log::BOTS.each do |bot|
            Log.search_by_description(bot).where(category: "Social Share").each do |log|
                case log.sub_category
                when "Twitter"
                    quote = Quote.find(log.source_id)
                    quote.twitter_share_count -= 1
                    quote.total_share_count -= 1
                    quote.save
                    log.destroy
                
                when "Facebook"
                    quote = Quote.find(log.source_id)
                    quote.facebook_share_count -= 1
                    quote.total_share_count -= 1
                    quote.save
                    log.destroy
                
                when "Pinterest"
                    quote = Quote.find(log.source_id)
                    quote.pinterest_share_count -= 1
                    quote.total_share_count -= 1
                    quote.save
                    log.destroy
                    
                when "Google Plus"
                    quote = Quote.find(log.source_id)
                    quote.google_plus_share_count -= 1
                    quote.total_share_count -= 1
                    quote.save
                    log.destroy    
                end
            end 
        end
    end
end