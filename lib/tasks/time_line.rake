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
    
    task :remove_non_existant => :environment do
        all_people = Person.all.select(:id)
        all_books = Book.all.select(:id)
        all_topics = Topic.all.select(:id)
        
        TimeLine.where.not(item_type: "Person", item_id: all_people).destroy_all
        TimeLine.where.not(item_type: "Book", item_id: all_books).destroy_all
        TimeLine.where.not(item_type: "Topic", item_id: all_topics).destroy_all
    end    
end