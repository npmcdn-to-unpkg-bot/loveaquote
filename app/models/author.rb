class Author < ActiveRecord::Base
    # has many quotes
    has_many :quotes, as: :source, dependent: :destroy
    has_many :featured_topics, as: :source, dependent: :destroy

    # has many books
    has_many :books
    has_many :book_quotes, through: :books, source: :quotes

    # name should be present and unique
    # slug should be present and unique
    
    validates :name, presence: true, uniqueness: true, blank: false
    validates :slug, presence: true, uniqueness: true, blank: false
    
    scope :published, -> {where(published: true)}
    scope :draft, -> {where(published: false)}
    scope :popular, -> { where(popular: true) }
    scope :very_popular, -> { where(very_popular: true) }
    scope :by_alphabet, ->(alphabet) {where('name like ?', "#{alphabet}%")}
    
    before_validation :generate_slug
    after_commit :fetch_quotes, on: :create
    after_save :add_to_time_line
    
    def to_param
        slug
    end    
    
    def generate_slug
        self.slug = (self.name + " " + "Quotes").to_url if !self.slug.present?
    end
    
    def all_quotes
        quotes = self.quotes.pluck(:id) + self.book_quotes.pluck(:id)
        Quote.where(id: quotes)
    end
    
    def fetch_quotes
        BrainyquoteWorker.perform_async(self.id) if self.fetch_url.present? && URI::parse(self.fetch_url).host == "www.brainyquote.com"
    end
    
    def asc_featured_topics
        Topic.where(id: self.featured_topics.pluck(:topic_id)).order(name: :ASC)
    end
    
    def featured_topic_quotes(featured_topic)
        self.all_quotes.includes(:quote_topics).where("quote_topics.topic_id" => featured_topic.id)
    end
    
    def non_featured_quotes
        self.all_quotes - self.all_quotes.includes(:quote_topics).where(quote_topics: { topic_id: self.featured_topics.pluck(:topic_id) })
    end
    
    def add_to_time_line
        TimeLine.create(item: self) if self.published
    end
end