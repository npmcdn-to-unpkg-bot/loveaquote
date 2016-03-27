class PersonProfession < ActiveRecord::Base
  belongs_to :person
  belongs_to :profession

  validates_uniqueness_of :profession, scope: [:person]
end
