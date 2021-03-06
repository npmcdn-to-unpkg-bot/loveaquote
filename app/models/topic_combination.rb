class TopicCombination < ActiveRecord::Base
    include Loggable
    include Seoable
    include SocialImageable

    belongs_to :topic, foreign_key: "primary_topic_id"

    validates :primary_topic_id, presence: true, blank: false
    validates :secondary_topic_id, presence: true, blank: false
    validates_uniqueness_of :secondary_topic_id, scope: [:primary_topic_id]

    validate :combination_should_not_exist

    before_validation :generate_slug
    after_commit :expire_cache, on: [:create, :destroy]

    def to_param
        slug
    end

    def generate_slug
        self.slug = (Topic.find(self.primary_topic_id).name + " and " + Topic.find(self.secondary_topic_id).name + " " + "Quotes").to_url if !self.slug.present?
    end

    def primary_topic
        Topic.find(self.primary_topic_id)
    end

    def secondary_topic
        Topic.find(self.secondary_topic_id)
    end

    def name
        self.primary_topic.name + " and " + self.secondary_topic.name
    end

    def image
        ""
    end

    def quotes
        primary_topic_quotes = self.primary_topic.quotes.pluck(:id)
        secondary_topic_quotes = self.secondary_topic.quotes.pluck(:id)
        Quote.where(id: primary_topic_quotes & secondary_topic_quotes)
    end

    def suggested_quotes
        primary_topic_suggested_quotes = self.primary_topic.quote_topic_suggestions.where(read: false).pluck(:quote_id)
        secondary_topic_suggested_quotes = self.secondary_topic.quote_topic_suggestions.where(read: false).pluck(:quote_id)
        Quote.where(id: primary_topic_suggested_quotes & secondary_topic_suggested_quotes)
    end

    def combination_should_not_exist
        if TopicCombination.exists?(primary_topic_id: self.primary_topic_id, secondary_topic_id: self.secondary_topic_id) || TopicCombination.exists?(primary_topic_id: self.secondary_topic_id, secondary_topic_id: self.primary_topic_id)
            errors[:base] << "This topic combination already exists."
        end
    end

    def similar_combinations
        first_primary = TopicCombination.where(primary_topic_id: self.primary_topic_id).where.not(id: self.id)
        second_primary = TopicCombination.where(primary_topic_id: self.secondary_topic_id).where.not(id: self.id)

        first_secondary = TopicCombination.where(secondary_topic_id: self.primary_topic_id).where.not(id: self.id)
        second_secondary = TopicCombination.where(secondary_topic_id: self.secondary_topic_id).where.not(id: self.id)

        first_primary | second_primary | first_secondary | second_secondary
    end

    def cached_similar_combinations
        Rails.cache.fetch("topic-combination-#{self.id}") do
            similar_combinations
        end
    end

    def expire_cache
        self.similar_combinations.each do |sc|
            Rails.cache.delete("topic-combination-#{sc.id}")
        end
    end
end