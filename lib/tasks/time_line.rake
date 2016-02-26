namespace :time_line do
    task :remove_duplicates => :environment do
        Person.published.each do |person|
            duplicates = TimeLine.where(item_type: "Person", item_id: person.id).order(created_at: :asc).offset(1)
            duplicates.destroy_all
        end
        
        Book.published.each do |book|
            duplicates = TimeLine.where(item_type: "Book", item_id: book.id).order(created_at: :asc).offset(1)
            duplicates.destroy_all
        end
        
        Topic.published.each do |topic|
            duplicates = TimeLine.where(item_type: "Topic", item_id: topic.id).order(created_at: :asc).offset(1)
            duplicates.destroy_all
        end
    end
end