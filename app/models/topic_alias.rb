class TopicAlias < ActiveRecord::Base
  belongs_to :topic
  
  validates :name, presence: true, uniqueness: true, blank: false
  
  before_create :capitalize_name
  after_commit :get_quote_suggestions
  before_update :capitalize_name

  def capitalize_name
    if self.name.present?
      self.name = self.name.capitalize
    end
  end

  def get_quote_suggestions
    SuggestTopicAliasQuotesWorker.perform_async(self.id)
  end
end
