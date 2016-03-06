class Quote < ActiveRecord::Base
    include PgSearch
    pg_search_scope :search_by_text, against: :text, using: { tsearch: {prefix: true} }
    
    # belongs to source
    belongs_to :source, polymorphic: true
    belongs_to :character
    
    has_one :chapter_and_page, dependent: :destroy
    accepts_nested_attributes_for :chapter_and_page, reject_if: :all_blank, allow_destroy: true
    
        has_one :season_and_episode, dependent: :destroy
    accepts_nested_attributes_for :season_and_episode, reject_if: :all_blank, allow_destroy: true
    
    has_many :quoted_in_books, dependent: :destroy
    accepts_nested_attributes_for :quoted_in_books, reject_if: :all_blank, allow_destroy: true
    
    has_many :quote_topics, dependent: :destroy
    accepts_nested_attributes_for :quote_topics, reject_if: :all_blank, allow_destroy: true
    
    has_many :topics, through: :quote_topics
    has_many :quote_topic_suggestions, dependent: :destroy
    has_many :logs, as: :source, dependent: :destroy
    
    # text should be present and unique
    validates :text, presence: true, uniqueness: true
    
    before_validation :strip_text
    after_commit :get_topic_suggestions, on: [:create, :update]
    after_update :touch_source
    
    def strip_text
        self.text = self.text.strip
    end
    
    def get_topic_suggestions
        SuggestTopicsWorker.perform_async(self.id)
    end
    
    def touch_source
        if self.text_changed?
            self.source.touch
            self.topics.each {|t| t.touch }
        end
    end
end