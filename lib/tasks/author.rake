namespace :author do
    task :rename_quote_source => :environment  do
        Quote.all.each do |quote|
            quote.source_type = "Person" if quote.source_type == "Author"
            quote.save
        end
    end
    
    rename :image => :environment do
    end
end