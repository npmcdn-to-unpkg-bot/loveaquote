class Quote < ActiveRecord::Base
    include PgSearch
    include Loggable

    pg_search_scope :search_by_text, against: :text, using: { tsearch: {prefix: true} }

    # belongs to source
    belongs_to :source, polymorphic: true, touch: true
    belongs_to :character

    has_many :quote_topics, dependent: :destroy
    accepts_nested_attributes_for :quote_topics, reject_if: :all_blank, allow_destroy: true

    has_many :topics, through: :quote_topics
    has_many :quote_topic_suggestions, dependent: :destroy

    has_many :quote_of_the_days, dependent: :destroy

    # text should be present and unique
    validates :text, presence: true, uniqueness: true
    validates :source_id, presence: true
    validates :source_type, presence: true

    before_validation :strip_text
    after_commit :get_topic_suggestions, on: [:create, :update]

    def strip_text
        self.text = self.text.strip
    end

    def get_topic_suggestions
        SuggestTopicsWorker.perform_async(self.id)
    end

    scope :filter_by_topic, -> (id) {joins(:quote_topics).where(quote_topics: {topic_id: id})}
end