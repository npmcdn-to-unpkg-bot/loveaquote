class QuoteOfTheDay < ActiveRecord::Base
  belongs_to :quote

  after_commit :expire_cache

  def self.today
    Rails.cache.fetch("qotd-#{Date.today.to_s(:number)}") do
        find_by(date: Date.today)
    end
  end
  
end
