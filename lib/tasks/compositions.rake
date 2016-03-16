namespace :compositions do
    task :add => :environment do
        Book.all.each do |book|
            Composition.create(book_id: book.id, person_id: book.person.id)
            puts "Added composition for book #{book.name}"
        end
    end
end