class Quote < ActiveRecord::Base
    # belongs to source
    belongs_to :source, polymorphic: true
    has_many :quote_topics, dependent: :destroy
    has_many :topics, through: :quote_topics
    has_many :quote_topic_suggestions, dependent: :destroy
    
    default_scope {order(text: :ASC)}
    
    # text should be present and unique
    validates :text, presence: true, uniqueness: true
    
    after_commit :get_topic_suggestions
    after_update :touch_source
     
    def get_topic_suggestions
        SuggestTopicsWorker.perform_async(self.id)
    end
    
    def touch_source
        if self.changed?
            self.source.touch
            self.topics.each {|t| t.touch }
        end
    end
    
end