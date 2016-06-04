class UserQuote < ActiveRecord::Base
  belongs_to :user
  belongs_to :quote
  
  validates_uniqueness_of :quote_id, scope: [:user_id]
  
  has_many :user_quote_user_lists, dependent: :destroy
  has_many :user_lists, through: :user_quote_user_lists
end