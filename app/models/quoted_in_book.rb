class QuotedInBook < ActiveRecord::Base
  belongs_to :quote
  validates :name, presence: true
  validates :author, presence: true
end
