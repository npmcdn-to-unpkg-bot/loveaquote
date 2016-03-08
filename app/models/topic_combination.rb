class TopicCombination < ActiveRecord::Base
    belongs_to :topic, foreign_key: "primary_topic_id"
    
    validates :primary_topic_id, presence: true, blank: false
    validates :secondary_topic_id, presence: true, blank: false
    validates_uniqueness_of :secondary_topic_id, scope: [:primary_topic_id]
    
    validate :combination_should_not_exist
    
    before_validation :generate_slug
    
    def to_param
        slug
    end
    
    def generate_slug
        self.slug = (Topic.find(self.primary_topic_id).name + " and " + Topic.find(self.secondary_topic_id).name + " " + "Quotes").to_url if !self.slug.present?
    end
    
    def primary_topic
        Topic.find(primary_topic_id)
    end
    
    def secondary_topic
        Topic.find(secondary_topic_id)
    end
    
    def name
        self.primary_topic.name + " and " + self.secondary_topic.name
    end
    
    def quotes
        primary_topic_quotes = self.primary_topic.quotes.pluck(:id)
        secondary_topic_quotes = self.secondary_topic.quotes.pluck(:id)
        Quote.where(id: primary_topic_quotes & secondary_topic_quotes)
    end
    
    def combination_should_not_exist
        if TopicCombination.exists?(primary_topic_id: self.primary_topic_id, secondary_topic_id: self.secondary_topic_id) || TopicCombination.exists?(primary_topic_id: self.secondary_topic_id, secondary_topic_id: self.primary_topic_id)
            errors[:base] << "This topic combination already exists."
        end
    end
end