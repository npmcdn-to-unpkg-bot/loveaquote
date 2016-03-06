namespace :quote_share_count do
    task :correct => :environment do 

        Log::BOTS.each do |bot|
            Log.search_by_description(bot).where(category: "Social Share").each do |log|
                case log.sub_category
                when "Twitter"
                    quote = Quote.find(log.source_id)
                    puts "Quote id - #{quote.id}"
                    puts "Quote Twitter Share Count - #{quote.twitter_share_count}"
                    puts "Quote Total Share Count - #{quote.total_share_count}"
                    quote.twitter_share_count -= 1
                    quote.total_share_count -= 1
                    quote.save
                    puts "Updated Twitter Share Count - #{quote.twitter_share_count}"
                    puts "Updated Total Share Count - #{quote.total_share_count}"
                    log.destroy
                
                when "Facebook"
                    quote = Quote.find(log.source_id)
                    puts "Quote Facebook Share Count - #{quote.facebook_share_count}"
                    puts "Quote Total Share Count - #{quote.total_share_count}"
                    quote.facebook_share_count -= 1
                    quote.total_share_count -= 1
                    quote.save
                    puts "Updated Facebook Share Count - #{quote.facebook_share_count}"
                    puts "Updated Total Share Count - #{quote.total_share_count}"                
                    log.destroy
                
                when "Pinterest"
                    quote = Quote.find(log.source_id)
                    puts "Quote Pinterest Share Count - #{quote.pinterest_share_count}"
                    puts "Quote Total Share Count - #{quote.total_share_count}"                
                    quote.pinterest_share_count -= 1
                    quote.total_share_count -= 1
                    quote.save
                    puts "Updated Pinterest Share Count - #{quote.pinterest_share_count}"
                    puts "Updated Total Share Count - #{quote.total_share_count}"                
                    log.destroy
                    
                when "Google Plus"
                    quote = Quote.find(log.source_id)
                    puts "Quote Google Plus Share Count - #{quote.google_plus_share_count}"
                    puts "Quote Total Share Count - #{quote.total_share_count}"                
                    quote.google_plus_share_count -= 1
                    quote.total_share_count -= 1
                    quote.save
                    puts "Updated Google Plus Share Count - #{quote.google_plus_share_count}"
                    puts "Updated Total Share Count - #{quote.total_share_count}"                
                    log.destroy    
                end
            end 
        end
    end
end