class FeaturedTopic < ActiveRecord::Base
  belongs_to :source, polymorphic: true
  belongs_to :topic
  
  validates :topic_id, presence: true, blank: false
end
