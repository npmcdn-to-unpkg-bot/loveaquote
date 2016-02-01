class CreateFeaturedTopics < ActiveRecord::Migration
  def change
    create_table :featured_topics do |t|
      t.references :source, index: true, polymorphic: true, null: false
      t.references :topic, index: true, null: false

      t.timestamps null: false
    end
  end
end
