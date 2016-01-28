class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.string :slug, index: true
      t.boolean :popular, default: false, null: false
      t.boolean :very_popular, default: false, null: false
      t.boolean :published, default: false, null: false

      t.timestamps null: false
    end
  end
end
