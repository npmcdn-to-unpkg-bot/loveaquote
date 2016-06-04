class UserQuoteUserList < ActiveRecord::Base
  belongs_to :user_quote
  belongs_to :user_list
end
