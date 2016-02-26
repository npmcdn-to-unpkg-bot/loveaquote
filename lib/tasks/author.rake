namespace :author do
    task :rename_quote_source => :environment  do
        Quote.all.each do |quote|
            quote.source_type = "Person" if quote.source_type == "Author"
            quote.save
        end
    end
    
    task :rename_time_line_item => :environment  do
        TimeLine.all.each do |tl|
            tl.item_type = "Person" if tl.item_type == "Author"
            tl.save
        end
    end
end