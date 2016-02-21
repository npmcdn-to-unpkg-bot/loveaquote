class Quote < ActiveRecord::Base
    # belongs to source
    belongs_to :source, polymorphic: true
    belongs_to :character
    has_many :quote_topics, dependent: :destroy
    has_many :topics, through: :quote_topics
    has_many :quote_topic_suggestions, dependent: :destroy
    
    # text should be present and unique
    validates :text, presence: true, uniqueness: true
    
    before_save :strip_text
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