namespace :generate_social_images  do
    task :all => :environment do
        ["Person", "Book", "Character", "Topic", "Movie", "TvShow", "TopicCombination", "Proverb"].each do |model|
            already_generated = SocialImage.where(source_type: model).pluck(:source_id)
            source = model.constantize.where.not(id: already_generated).first
            SocialImageWorker.perform_async(source.class.name, source.id) if source.present?
        end
    end
end