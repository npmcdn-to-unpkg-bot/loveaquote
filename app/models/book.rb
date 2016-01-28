class Book < ActiveRecord::Base
    # has many quotes
    has_many :quotes, as: :source, dependent: :destroy
    
    belongs_to :author
    
    # name should be present and unique
    # slug should be present and unique
    # author should be present
    validates :name, presence: true, uniqueness: true
    validates :slug, presence: true, uniqueness: true
    validates :author_id, presence: true, uniqueness: true
    
    before_validation :generate_slug
    after_commit :fetch_quotes
    
    def to_param
        slug
    end
    
    def generate_slug
        self.slug = (self.name + " " + "Quotes").to_url if !self.slug.present?
    end
    
    def fetch_quotes
        GoodreadsWorker.perform_async(self.id) if self.fetch_url.present? && URI::parse(self.fetch_url).host == "www.goodreads.com"        
    end
end
