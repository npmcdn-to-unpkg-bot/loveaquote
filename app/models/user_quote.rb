class UserQuote < ActiveRecord::Base
  belongs_to :user
  belongs_to :quote
  
  validates_uniqueness_of :quote_id, scope: [:user_id]
end