class QuoteTopic < ActiveRecord::Base
    belongs_to :quote
    belongs_to :topic
    
    validates :topic_id, presence: true
    validates :topic_id, presence: true
    
    validates_uniqueness_of :topic_id, scope: :quote_id
    
    after_create :touch_topic
    
    def touch_topic
        self.topic.touch    
    end
end
