class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :fetch_url
      t.string :slug, index: true
      t.boolean :published, default: false, null: false
      t.boolean :popular, default: false, null: false
      t.boolean :very_popular, default: false, null: false
      t.references :author

      t.timestamps null: false
    end
  end
end
