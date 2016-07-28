class NotFoundJob < Struct.new(:slug, :ua)
  def perform(slug, ua)
      Log.create(category: "404 Not Found", description: slug + " - " + ua)
  end
end