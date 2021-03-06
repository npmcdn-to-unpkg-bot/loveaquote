class Quote < ActiveRecord::Base
    include ActionView::Helpers::TextHelper
    include PgSearch
    include Loggable
    include SocialImageable
    
    has_attached_file :image, 
        styles: { medium: "600x600>" },
        url: "/uploads/:class/:id/:slug_:style.:extension",
        path: ":rails_root/public:url"
        
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    
    Paperclip.interpolates :slug  do |attachment, style|
        attachment.instance.slug
    end
    
    pg_search_scope :search_by_text, against: :text, using: { tsearch: {prefix: true} }

    # belongs to source
    belongs_to :source, polymorphic: true, touch: true
    belongs_to :character

    has_many :quote_topics, dependent: :destroy
    accepts_nested_attributes_for :quote_topics, reject_if: :all_blank, allow_destroy: true

    has_many :topics, through: :quote_topics
    has_many :quote_topic_suggestions, dependent: :destroy

    has_many :quote_of_the_days, dependent: :destroy
    has_many :tweetable_quotes, dependent: :destroy
    has_many :user_quotes, dependent: :destroy

    # text should be present and unique
    validates :text, presence: true, uniqueness: true
    validates :source_id, presence: true
    validates :source_type, presence: true

    before_validation :strip_text, :generate_slug
    after_save :get_topic_suggestions

    def strip_text
        self.text = self.text.strip
    end
    
    def generate_slug
        unless self.slug.present?
            case self.source.class.name
            when "Person"
                quote_length = 70 - self.source.name.length - 4
            when "Book"
                quote_length = 70 - self.source.name.length - 6
            when "Movie"
                quote_length = 70 - self.source.name.length - 6
            when "TvShow"
                quote_length = 70 - self.source.name.length - 6
            when "Proverb"
                quote_length = 70 - (self.source.name + " Proverb").length - 3
            end
            slug = truncate(self.text, length: quote_length, separator: ' ').tr('.','')
            self.slug = slug.to_url
        end
    end

    def get_topic_suggestions
        Delayed::Job.enqueue SuggestTopicsJob.new(self.id)
    end
    
    scope :verified, -> {where(verified: true)}
    scope :filter_by_topic, -> (id) {joins(:quote_topics).where(quote_topics: {topic_id: id})}
    
    scope :with_image, -> (count) { where(image_width: 1200, image_height: 600).order(created_at: :DESC).limit(count) }
    
    def self.cached_with_image(count)
        Rails.cache.fetch("quotes-with-images-#{count.to_s}-#{Date.today.to_s(:number)}") do
            with_image(count)
        end
    end
end