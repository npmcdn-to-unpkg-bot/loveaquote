class CharacterSource < ActiveRecord::Base
  belongs_to :character
  belongs_to :source, polymorphic: true
end
