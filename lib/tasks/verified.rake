namespace :verified do
    task :mark => :environment do
        ChapterAndPage.all.each do |cp|
            cp.quote.update_columns(verified: true)
        end
        
        SeasonAndEpisode.all.each do |se|
            se.quote.update_columns(verified: true)
        end
        
        FoundAt.all.each do |fa|
            fa.quote.update_columns(verified: true)
        end
        
        QuotedInBook.all.each do |qib|
            qib.quote.update_columns(verified: true)
        end
    end
end