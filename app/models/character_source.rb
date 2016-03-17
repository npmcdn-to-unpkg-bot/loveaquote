class CharacterSource < ActiveRecord::Base
  belongs_to :character
  belongs_to :person
  belongs_to :source, polymorphic: true

  validates_uniqueness_of :character_id, scope: [:source_id, :source_type]
end