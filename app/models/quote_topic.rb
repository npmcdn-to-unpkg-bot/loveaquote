class QuoteTopic < ActiveRecord::Base
    belongs_to :quote
    belongs_to :topic
    
    validates_uniqueness_of :quote_id, scope: :topic_id
    
    after_create :touch_topic
    
    def touch_topic
        self.topic.touch    
    end
end
