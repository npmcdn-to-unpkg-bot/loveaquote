class Quote < ActiveRecord::Base
    include ActionView::Helpers::TextHelper
    include PgSearch
    include Loggable
    mount_uploader :image, QuoteImageUploader
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

    # text should be present and unique
    validates :text, presence: true, uniqueness: true
    validates :source_id, presence: true
    validates :source_type, presence: true

    before_validation :strip_text, :generate_slug
    after_commit :get_topic_suggestions, on: [:create, :update]

    def strip_text
        self.text = self.text.strip
    end
    
    def generate_slug
        unless self.slug.present?
            case self.source.class.name
            where "Person"
                quote_length = 70 - self.source.name.length - 4
            where "Book"
                quote_length = 70 - self.source.name.length - 6
            where "Movie"
                quote_length = 70 - self.source.name.length - 6
            where "TvShow"
                quote_length = 70 - self.source.name.length - 6
            where "Proverb"
                quote_length = 70 - (self.source.name + " Proverb").length - 3
            end
            slug = truncate(self.text, length: quote_length, separator: ' ').tr('.','')
            self.slug = slug.to_url
        end
    end

    def get_topic_suggestions
        SuggestTopicsWorker.perform_async(self.id)
    end

    scope :filter_by_topic, -> (id) {joins(:quote_topics).where(quote_topics: {topic_id: id})}
end