class TvShow < ActiveRecord::Base
    include PgSearch
    pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }
    
    # has many quotes
    has_one :time_line, as: :item, dependent: :destroy
    has_many :quotes, as: :source, dependent: :destroy
    has_many :quote_topic_suggestions, through: :quotes
    has_many :featured_topics, as: :source, dependent: :destroy
    has_many :character_sources, as: :source, dependent: :destroy
    has_many :characters, through: :character_sources
    
    mount_uploader :image, ImageUploader
    
    validates :name, presence: true, uniqueness: true, blank: false
    validates :slug, presence: true, uniqueness: true, blank: false
    
    scope :published, -> {where(published: true)}
    scope :draft, -> {where(published: false)}
    scope :popular, -> { where(popular: true) }
    scope :very_popular, -> { where(very_popular: true) }
    scope :by_alphabet, ->(alphabet) {where('name like ?', "#{alphabet}%")}
    
    before_validation :strip_name, :generate_slug
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
    
    def add_to_time_line
        TimeLine.create(item: self) if self.published
    end    
end