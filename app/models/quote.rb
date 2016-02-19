class Quote < ActiveRecord::Base
    # belongs to source
    belongs_to :source, polymorphic: true
    has_many :quote_topics, dependent: :destroy
    has_many :topics, through: :quote_topics
    has_many :quote_topic_suggestions, dependent: :destroy
    
    default_scope {order(text: :ASC)}
    
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
    
    def source_url
        case self.source_type
        when "Author"
            "http://www.loveaquote.com/authors/#{self.source.slug}"
        when "Book"
            "http://www.loveaquote.com/books/#{self.source.slug}"
        else
            "http://www.loveaquote.com"
        end
    end
end