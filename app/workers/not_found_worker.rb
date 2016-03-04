class NotFoundWorker
  include Sidekiq::Worker
  
  def perform(slug)
      Log.create(category: "404 Not Found", description: slug)
  end
end