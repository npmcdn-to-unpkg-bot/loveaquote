class MyQuote < ActiveRecord::Base
  belongs_to :user
  belongs_to :quote
  
  has_many :my_quote_my_lists, dependent: :destroy
  accepts_nested_attributes_for :quote_topics, reject_if: :all_blank, allow_destroy: true
end
