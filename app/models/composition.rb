class Composition < ActiveRecord::Base
  belongs_to :book
  belongs_to :person

  validates_uniqueness_of :book_id, scope: [:person_id]
end
