class Character < ActiveRecord::Base
    include PgSearch
    pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }
    
    has_many :character_sources, dependent: :destroy
    has_many :books, through: :character_sources, source: :source, source_type: "Book"
    has_many :people, through: :character_sources
    has_many :quotes
    has_many :logs, as: :source, dependent: :destroy
    
    mount_uploader :image, ImageUploader
    
    validates :name, presence: true, uniqueness: true, blank: false
    
    scope :published, -> {where(published: true)}
    scope :draft, -> {where(published: false)}
    scope :popular, -> { where(popular: true) }
    scope :very_popular, -> { where(very_popular: true) }
    scope :by_alphabet, ->(alphabet) {where('name like ?', "#{alphabet}%")}
    
    before_validation :strip_name, :generate_slug
    
    def to_param
        slug
    end
    
    def strip_name
        self.name = self.name.strip
    end
    
    def generate_slug
        self.slug = (self.name + " " + "Quotes").to_url if !self.slug.present?
    end
end
