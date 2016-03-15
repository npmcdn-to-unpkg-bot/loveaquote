class Person < ActiveRecord::Base
    include PgSearch
    include Quotable
    include Loggable
    include Searchable
    include Seoable
    include SocialImageable
    
    pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }
    
    belongs_to :nationality
    belongs_to :profession
    has_one :time_line, as: :item, dependent: :destroy
    has_many :quote_topic_suggestions, through: :quotes
    has_many :featured_topics, as: :source, dependent: :destroy
    has_many :character_sources
    has_many :characters, -> {uniq}, through: :character_sources
    has_many :character_quotes, through: :characters, source: :quotes
    has_many :search_suggestions, as: :source, dependent: :destroy

    # has many books
    has_many :books
    has_many :book_quotes, through: :books, source: :quotes

    mount_uploader :image, ImageUploader

    # name should be present and unique
    # slug should be present and unique
    
    validates :name, presence: true, uniqueness: true, blank: false
    validates :slug, presence: true, uniqueness: true, blank: false
    
    scope :published, -> {where(published: true)}
    scope :draft, -> {where(published: false)}
    scope :popular, -> { where(popular: true) }
    scope :very_popular, -> { where(very_popular: true) }
    scope :by_alphabet, ->(alphabet) {where('name like ?', "#{alphabet}%")}
    
    before_validation :strip_name, :generate_slug
    after_commit :fetch_quotes, on: [:create, :update]
    after_save :add_to_time_line, :expire_cache
    
    def to_param
        slug
    end    
    
    def strip_name
        self.name = self.name.strip
    end
    
    def generate_slug
        self.slug = (self.name + " " + "Quotes").to_url if !self.slug.present?
    end
    
    def all_quotes
        quotes = self.quotes.pluck(:id) + self.book_quotes.pluck(:id) + self.character_quotes.pluck(:id)
        Quote.where(id: quotes)
    end
    
    def fetch_quotes
        BrainyquoteWorker.perform_async(self.id) if self.fetch_url.present? && URI::parse(self.fetch_url).host == "www.brainyquote.com"
    end
    
    def add_to_time_line
        TimeLine.create(item: self) if self.published
    end
    
    def self.cached_very_popular
        Rails.cache.fetch("very_popular_people") do
            very_popular.published.order(name: "ASC").to_a
        end
    end
    
    def expire_cache
        Rails.cache.delete("very_popular_people") if self.very_popular? && self.very_popular_changed?
    end
end