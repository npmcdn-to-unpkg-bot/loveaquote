class Topic < ActiveRecord::Base
    has_many :quote_topics, dependent: :destroy
    has_many :quotes, through: :quote_topics
    
    # name should be present and unique
    # slug should be present and unique
    validates :name, presence: true, uniqueness: true
    validates :slug, presence: true, uniqueness: true
    
    before_validation :generate_slug

    def to_param
        slug
    end
    
    def generate_slug
        self.slug = (self.name + " " + "Quotes").to_url if !self.slug.present?
    end
end
