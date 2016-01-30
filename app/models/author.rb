class Author < ActiveRecord::Base
    # has many quotes
    has_many :quotes, as: :source, dependent: :destroy
    
    # has many books
    has_many :books
    
    # name should be present and unique
    # slug should be present and unique
    
    validates :name, presence: true, uniqueness: true, blank: false
    validates :slug, presence: true, uniqueness: true, blank: false
    
    before_validation :generate_slug
    after_commit :fetch_quotes
    
    def to_param
        slug
    end    
    
    def generate_slug
        self.slug = (self.name + " " + "Quotes").to_url if !self.slug.present?
    end
    
    def fetch_quotes
        BrainyquoteWorker.perform_async(self.id) if self.fetch_url.present? && URI::parse(self.fetch_url).host == "www.brainyquote.com"
    end
end