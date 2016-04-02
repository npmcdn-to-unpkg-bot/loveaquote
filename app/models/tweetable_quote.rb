class TweetableQuote < ActiveRecord::Base
  belongs_to :quote
  
  validates :quote_id, presence: true, uniqueness: true, blank: false
  validate :quote_length
  
  def quote_length
    errors.add(:quote_id, "quote length is greater than 95 characters") if self.quote.text.length > 95
  end
end
