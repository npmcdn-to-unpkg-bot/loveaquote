class Person < ActiveRecord::Base
    include PgSearch
    include Quotable
    include Loggable
    include Searchable
    include Seoable
    include Imageable    
    include SocialImageable
    include TimeLineable
    include SearchSuggestable
    include Reviewable
    include FeaturedTopicable
    include Details

    pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }

    belongs_to :nationality

    has_many :person_professions, dependent: :destroy
    accepts_nested_attributes_for :person_professions, reject_if: :all_blank, allow_destroy: true
    has_many :professions, through: :person_professions

    has_many :quote_topic_suggestions, through: :quotes
    has_many :character_sources
    has_many :characters, -> {uniq}, through: :character_sources
    has_many :character_quotes, through: :characters, source: :quotes

    # has many books
    has_many :compositions
    has_many :books, through: :compositions
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

    after_commit :fetch_quotes, on: [:create, :update]
    after_save :expire_cache

    def to_param
        slug
    end

    def all_quotes
        quotes = self.quotes.pluck(:id) + self.book_quotes.pluck(:id) + self.character_quotes.pluck(:id)
        Quote.where(id: quotes)
    end

    def fetch_quotes
        Delayed::Job.enqueue BrainyquoteJob.new(self.id) if self.fetch_url.present? && URI::parse(self.fetch_url).host == "www.brainyquote.com"
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