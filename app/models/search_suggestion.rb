class SearchSuggestion < ActiveRecord::Base
  belongs_to :source, polymorphic: true
  
  validates :name, presence: true, blank: false
  validates_uniqueness_of :name, scope: [:source_id, :source_type]
end
