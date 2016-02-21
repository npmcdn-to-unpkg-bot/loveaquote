class Character < ActiveRecord::Base
    has_many :character_sources, dependent: :destroy
    has_many :books, through: :character_sources, source: :source, source_type: "Book"
    
    has_many :quotes
    
    mount_uploader :image, ImageUploader
    
    validates :name, presence: true, uniqueness: true, blank: false
    
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
