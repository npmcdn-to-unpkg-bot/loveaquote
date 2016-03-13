class Topic < ActiveRecord::Base
    include PgSearch
    include Loggable
    include Searchable
    include Seoable
    
    pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }
    
    has_one :time_line, as: :item, dependent: :destroy
    has_many :quote_topics, dependent: :destroy
    has_many :quotes, through: :quote_topics
    has_many :topic_aliases, dependent: :destroy
    has_many :topic_combinations, foreign_key: "primary_topic_id", dependent: :destroy
    accepts_nested_attributes_for :topic_combinations, reject_if: :all_blank, allow_destroy: true
    has_many :search_suggestions, dependent: :destroy
    has_many :quote_topic_suggestions, dependent: :destroy
    
    # name should be present and unique
    # slug should be present and unique
    validates :name, presence: true, uniqueness:true, blank: false
    validates :slug, presence: true, uniqueness:true, blank: false
    
    scope :published, -> {where(published: true)}
    scope :draft, -> {where(published: false)}
    scope :popular, -> {where(popular: true)}
    scope :very_popular, -> {where(very_popular: true)}
    scope :by_alphabet, ->(alphabet) {where('name like ?', "#{alphabet}%")}

    before_validation :strip_name, :capitalize_name, :generate_slug
    after_create :get_quote_suggestions
    after_save :add_to_time_line    

    def to_param
        slug
    end
    
    def strip_name
        self.name = self.name.strip
    end
    
    def generate_slug
        self.slug = (self.name + " " + "Quotes").to_url if !self.slug.present?
    end
    
    def capitalize_name
        self.name = self.name.capitalize
    end
    
    def get_quote_suggestions
        SuggestTopicQuotesWorker.perform_async(self.id)
    end
    
    def add_to_time_line
        TimeLine.create(item: self) if self.published
    end
    
    def all_topic_combinations
        TopicCombination.where("primary_topic_id = ? OR secondary_topic_id = ?", self.id, self.id)
    end
    
    def expire_cache
        Rails.cache.delete("front_page") if self.very_popular? && self.very_popular_changed?
    end
end
