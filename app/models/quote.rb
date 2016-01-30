class Quote < ActiveRecord::Base
    # belongs to source
    belongs_to :source, polymorphic: true
    has_many :quote_topics, dependent: :destroy
    has_many :topics, through: :quote_topics
    has_many :quote_topic_suggestions, dependent: :destroy
    
    # text should be present and unique
    validates :text, presence: true, uniqueness: true
    
    after_commit :get_topic_suggestions
     
    def get_topic_suggestions
        SuggestTopicsWorker.perform_async(self.id)
    end
end