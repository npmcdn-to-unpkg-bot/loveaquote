class QuoteTopicSuggestion < ActiveRecord::Base
    belongs_to :quote
    belongs_to :topic

    validates :quote_id, presence: true, blank: false
    validates :topic_id, presence: true, blank: false

    validates_uniqueness_of :quote_id, scope: :topic_id
end
