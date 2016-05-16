class MyQuote < ActiveRecord::Base
  belongs_to :user
  belongs_to :quote
end
