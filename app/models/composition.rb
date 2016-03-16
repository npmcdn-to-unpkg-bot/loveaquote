class Composition < ActiveRecord::Base
  belongs_to :book
  belongs_to :person
  
  validates :book_id, presence: true
  validates :person_id, presence: true
  
  validates_uniqueness_of :book_id, scope: [:person_id]
end
