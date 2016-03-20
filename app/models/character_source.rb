class CharacterSource < ActiveRecord::Base
  belongs_to :character, touch: true
  belongs_to :person, touch: true
  belongs_to :source, polymorphic: true, touch: true

  validates_uniqueness_of :character_id, scope: [:source_id, :source_type]
end