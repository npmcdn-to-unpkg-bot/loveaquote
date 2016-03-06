namespace :quote_share_count do
    task :correct => :environment do 
        
        Log.where(source_type: "Quote", category: "Social Share", sub_category: "Twitter").each do |log|
            unless log.description.present?
                quote = Quote.find(log.source_id)
                quote.twitter_share_count -= 1
                quote.total_share_count -= 1
                quote.save
                log.destroy
            end
        end
            
        Log.where(source_type: "Quote", category: "Social Share", sub_category: "Facebook").each do |log|
            unless log.description.present?
                quote = Quote.find(log.source_id)
                quote.facebook_share_count -= 1
                quote.total_share_count -= 1
                quote.save
                log.destroy
            end    
        end
        
        Log.where(source_type: "Quote", category: "Social Share", sub_category: "Pinterest").each do |log|
            unless log.description.present?
                quote = Quote.find(log.source_id)
                quote.pinterest_share_count -= 1
                quote.total_share_count -= 1
                quote.save
                log.destroy
            end    
        end
        
        bots = ["seokicks"]
        
        bots.each do |bot|
            Log.search_by_description(bot).where(source_type: "Quote", category: "Social Share", sub_category: "Twitter").each do |log|
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
            end
                
            Log.search_by_description(bot).where(source_type: "Quote", category: "Social Share", sub_category: "Facebook").each do |log|
                quote = Quote.find(log.source_id)
                puts "Quote Facebook Share Count - #{quote.facebook_share_count}"
                puts "Quote Total Share Count - #{quote.total_share_count}"
                quote.facebook_share_count -= 1
                quote.total_share_count -= 1
                quote.save
                puts "Updated Facebook Share Count - #{quote.facebook_share_count}"
                puts "Updated Total Share Count - #{quote.total_share_count}"                
                log.destroy
            end
            
            Log.search_by_description(bot).where(source_type: "Quote", category: "Social Share", sub_category: "Pinterest").each do |log|
                quote = Quote.find(log.source_id)
                puts "Quote Pinterest Share Count - #{quote.pinterest_share_count}"
                puts "Quote Total Share Count - #{quote.total_share_count}"                
                quote.pinterest_share_count -= 1
                quote.total_share_count -= 1
                quote.save
                puts "Updated Pinterest Share Count - #{quote.pinterest_share_count}"
                puts "Updated Total Share Count - #{quote.total_share_count}"                
                log.destroy
            end 
        end
        
    end
end