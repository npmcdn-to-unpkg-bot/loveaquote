namespace :quote_share_count do
    task :update => :environment do
        
        #update based on social share count
        Quote.find_each(batch_size: 100) do |quote|
            total_share_count = quote.facebook_share_count + quote.twitter_share_count + quote.pinterest_share_count + quote.google_plus_share_count
            total_share_count += 1 if quote.image.present?
            
            quote.update_columns(total_share_count: total_share_count)
        end
        
        #update based on occurence in quote of the day
        QuoteOfTheDay.find_each(batch_size: 100) do |qotd|
            qotd.quote.update_columns(total_share_count: qotd.quote.total_share_count + 1)
        end
        
        #update based on occurence in tweetable quotes
        
        TweetableQuote.find_each(batch_size: 100) do |tweetable_quote|
           tweetable_quote.quote.update_columns(total_share_count: tweetable_quote.quote.total_share_count + 1) 
        end
        
        #update based on occurence in user lists
        ListQuote.find_each(batch_size: 100) do |list_quote|
            list_quote.quote.update_columns(total_share_count: list_quote.quote.total_share_count + 1)
        end
    end
end