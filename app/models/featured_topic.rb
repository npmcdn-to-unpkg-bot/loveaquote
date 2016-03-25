class FeaturedTopic < ActiveRecord::Base
  belongs_to :source, polymorphic: true, touch: true
  belongs_to :topic

  validates :topic_id, presence: true, blank: false
  validates_uniqueness_of :topic_id, scope: [:source_id, :source_type]

  before_validation :generate_slug, on: [:create]

  def generate_slug
    self.slug = ("On " + self.topic.name).to_url
  end

  def to_param
      slug
  end
end
