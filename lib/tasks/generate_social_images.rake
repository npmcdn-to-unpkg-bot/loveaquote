namespace :generate_social_images  do
    task :all => :environment do
        ["Person", "Book", "Character", "Topic", "Movie", "TvShow", "TopicCombination", "Proverb"].each do |model|
            model.constantize.all.each do |source|
                SocialImageWorker.perform_async(source.class.name, source.id)
                sleep(5)
            end
        end
    end
end