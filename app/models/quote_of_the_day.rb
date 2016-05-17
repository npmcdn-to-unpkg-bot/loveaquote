class QuoteOfTheDay < ActiveRecord::Base
  belongs_to :quote
  after_create :generate_image

  def self.today
    Rails.cache.fetch("qotd-#{Date.today.to_s(:number)}") do
        find_by(date: Date.today)
    end
  end
  
  def generate_image
    QuoteImageWorker.perform_async(self.quote.id)
  end
end
