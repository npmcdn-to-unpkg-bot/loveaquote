class Proverb < ActiveRecord::Base
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
    
    pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }

    # has many quotes
    has_one :time_line, as: :item, dependent: :destroy
    has_many :quote_topic_suggestions, through: :quotes
    has_many :featured_topics, as: :source, dependent: :destroy

    # name should be present and unique
    # slug should be present and unique
    # person should be present
    validates :name, presence: true, uniqueness: true, blank: false
    validates :slug, presence: true, uniqueness: true, blank: false

    scope :published, -> {where(published: true)}
    scope :draft, -> {where(published: false)}
    scope :popular, -> { where(popular: true) }
    scope :very_popular, -> { where(very_popular: true) }
    scope :by_alphabet, ->(alphabet) {where('name like ?', "#{alphabet}%")}

    after_save :expire_cache

    def to_param
        slug
    end

    def self.cached_very_popular
        Rails.cache.fetch("very_popular_proverb") do
            very_popular.published.order(name: "ASC").to_a
        end
    end

    def expire_cache
        Rails.cache.delete("very_popular_proverb") if self.very_popular? && self.very_popular_changed?
    end
end
