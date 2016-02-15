class QuoteTopic < ActiveRecord::Base
    belongs_to :quote
    belongs_to :topic
    
    after_create :touch_topic
    
    def touch_topic
        self.topic.touch    
    end
end
