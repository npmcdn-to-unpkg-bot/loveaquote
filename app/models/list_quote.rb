class ListQuote < ActiveRecord::Base
  belongs_to :list
  belongs_to :quote
end