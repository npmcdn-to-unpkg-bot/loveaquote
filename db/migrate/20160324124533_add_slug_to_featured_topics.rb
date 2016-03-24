class AddSlugToFeaturedTopics < ActiveRecord::Migration
  def change
    add_column :featured_topics, :slug, :string
  end
end
