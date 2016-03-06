class CharacterSource < ActiveRecord::Base
  belongs_to :character
  belongs_to :source, polymorphic: true
  
  validates :character_id, presence: true, blank: false
  validates :source_id, presence: true, blank: false
  validates :source_type, presence: true, blank: false
  
  validates_uniqueness_of :character_id, scope: [:source_id, :source_type]
end
