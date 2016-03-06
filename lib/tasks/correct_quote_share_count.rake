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
        
    end
end