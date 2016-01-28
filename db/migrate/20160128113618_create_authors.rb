class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :slug, index: true
      t.string :fetch_url
      t.boolean :published, default: false, null: false
      t.boolean :popular, default: false, null: false
      t.boolean :very_popular, default: false, null: false

      t.timestamps null: false
    end
  end
end