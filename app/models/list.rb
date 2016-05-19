class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_quotes, dependent: :destroy
  has_many :quotes, through: :list_quotes
  
  validates_uniqueness_of :name, scope: [:user_id]
end