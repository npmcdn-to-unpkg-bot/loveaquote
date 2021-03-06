class Movie < ActiveRecord::Base
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
    
    pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }

    # has many quotes
    has_one :time_line, as: :item, dependent: :destroy
    has_many :quote_topic_suggestions, through: :quotes
    has_many :featured_topics, as: :source, dependent: :destroy

    has_many :character_sources, as: :source, dependent: :destroy
    accepts_nested_attributes_for :character_sources, reject_if: :all_blank, allow_destroy: true
    has_many :characters, through: :character_sources

    validates :name, presence: true, uniqueness: true, blank: false
    validates :slug, presence: true, uniqueness: true, blank: false

    scope :published, -> {where(published: true)}
    scope :draft, -> {where(published: false)}
    scope :popular, -> { where(popular: true) }
    scope :very_popular, -> { where(very_popular: true) }
    scope :by_alphabet, ->(alphabet) {where('name like ?', "#{alphabet}%")}

    def to_param
        slug
    end
end