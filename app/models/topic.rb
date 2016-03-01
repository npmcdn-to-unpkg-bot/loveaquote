class Topic < ActiveRecord::Base
    include PgSearch
    pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }
    
    has_one :time_line, as: :item, dependent: :destroy
    has_many :quote_topics, dependent: :destroy
    has_many :quotes, through: :quote_topics
    has_many :topic_aliases, dependent: :destroy
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
    after_commit :get_quote_suggestions
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
end
