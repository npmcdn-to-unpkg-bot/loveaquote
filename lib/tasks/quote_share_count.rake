namespace :quote_share_count do
    task :update => :environment do
        Quote.find_each(batch_size: 100) do |quote|
            total_share_count = quote.facebook_share_count + quote.twitter_share_count + quote.pinterest_share_count + quote.google_plus_share_count
            total_share_count += 1 if quote.image.present?
            
            quote.update_columns(total_share_count: total_share_count)
        end
    end
end