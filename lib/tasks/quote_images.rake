namespace :quote_images do
    task :regenerate => :environment do
        Quote.where.not(image: '').each do |quote|
            QuoteImageWorker.perform_async(quote.id)
            sleep(1)
        end
    end
end