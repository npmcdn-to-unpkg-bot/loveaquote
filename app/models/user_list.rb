class UserList < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :name, scope: [:user_id]
  
  has_many :user_quote_user_lists, dependent: :destroy
  has_many :user_quotes, through: :user_quote_user_lists
end