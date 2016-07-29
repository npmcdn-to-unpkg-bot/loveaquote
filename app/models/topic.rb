class Topic < ActiveRecord::Base
    include PgSearch
    include Loggable
    include Searchable
    include Seoable
    include Imageable    
    include SocialImageable
    include TimeLineable
    include SearchSuggestable
    include Reviewable

    pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }

    has_one :time_line, as: :item, dependent: :destroy
    has_many :quote_topics, dependent: :destroy
    has_many :quotes, through: :quote_topics
    has_many :topic_aliases, dependent: :destroy
    accepts_nested_attributes_for :topic_aliases, reject_if: :all_blank, allow_destroy: true
    has_many :topic_combinations, foreign_key: "primary_topic_id", dependent: :destroy
    accepts_nested_attributes_for :topic_combinations, reject_if: :all_blank, allow_destroy: true
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

    after_create :get_quote_suggestions

    def to_param
        slug
    end

    def get_quote_suggestions
        Delayed::Job.enqueue SuggestTopicQuotesJob.new(self.id)
    end

    def add_to_time_line
        TimeLine.create(item: self) if self.published
    end

    def all_topic_combinations
        pt = TopicCombination.where(primary_topic_id: self.id).pluck(:id)
        st = TopicCombination.where(secondary_topic_id: self.id).pluck(:id)
        TopicCombination.where(id: pt + st)
    end

    def self.cached_very_popular
        Rails.cache.fetch("very_popular_topic") do
            very_popular.published.order(name: "ASC").to_a
        end
    end

    def expire_cache
        Rails.cache.delete("very_popular_topic") if self.very_popular? && self.very_popular_changed?
    end
end
