class MyQuote < ActiveRecord::Base
  belongs_to :user
  belongs_to :quote
  
  has_many :my_quote_my_lists, dependent: :destroy
end
