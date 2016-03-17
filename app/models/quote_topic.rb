class QuoteTopic < ActiveRecord::Base
    belongs_to :quote, touch: true
    belongs_to :topic, touch: true

    validates :quote_id, presence: true
    validates :topic_id, presence: true

    validates_uniqueness_of :topic_id, scope: :quote_id
end
