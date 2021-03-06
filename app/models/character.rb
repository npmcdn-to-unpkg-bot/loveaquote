class Character < ActiveRecord::Base
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

    has_many :character_sources, dependent: :destroy
    has_many :books, through: :character_sources, source: :source, source_type: "Book"
    has_many :people, through: :character_sources
    has_many :quotes

    validates :name, presence: true, uniqueness: true, blank: false

    scope :published, -> {where(published: true)}
    scope :draft, -> {where(published: false)}
    scope :popular, -> { where(popular: true) }
    scope :very_popular, -> { where(very_popular: true) }
    scope :by_alphabet, ->(alphabet) {where('name like ?', "#{alphabet}%")}

    def to_param
        slug
    end
end
