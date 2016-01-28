class Quote < ActiveRecord::Base
    # belongs to source
    belongs_to :source, polymorphic: true
    has_many :quote_topics, dependent: :destroy
    has_many :topics, through: :quote_topics
    
    # text should be present and unique
    validates :text, presence: true, uniqueness: true
end