class Book < ActiveRecord::Base
    include PgSearch
    include Quotable
    include Loggable
    include Searchable
    include Seoable
    include SocialImageable
    include TimeLineable
    include SearchSuggestable

    pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }

    # has many quotes
    has_many :quote_topic_suggestions, through: :quotes
    has_many :featured_topics, as: :source, dependent: :destroy

    has_many :character_sources, as: :source, dependent: :destroy
    accepts_nested_attributes_for :character_sources, reject_if: :all_blank, allow_destroy: true
    has_many :characters, through: :character_sources

    has_many :compositions
    accepts_nested_attributes_for :compositions, reject_if: :all_blank, allow_destroy: true
    has_many :people, through: :compositions


    mount_uploader :image, ImageUploader

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

    before_validation :strip_name, :generate_slug
    after_commit :fetch_quotes, on: [:create, :update]
    after_save :expire_cache

    def to_param
        slug
    end

    def strip_name
        self.name = self.name.strip
    end

    def generate_slug
        self.slug = (self.name + " " + "Quotes").to_url if !self.slug.present?
    end

    def fetch_quotes
        GoodreadsWorker.perform_async(self.id) if self.fetch_url.present? && URI::parse(self.fetch_url).host == "www.goodreads.com"
    end

    def self.cached_very_popular
        Rails.cache.fetch("very_popular_book") do
            very_popular.published.order(name: "ASC").to_a
        end
    end

    def expire_cache
        Rails.cache.delete("very_popular_book") if self.very_popular? && self.very_popular_changed?
    end
end
