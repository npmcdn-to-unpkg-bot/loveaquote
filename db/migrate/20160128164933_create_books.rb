class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :fetch_url
      t.string :slug, index: true, unique: true
      t.boolean :published, default: false, null: false
      t.boolean :popular, default: false, null: false
      t.boolean :very_popular, default: false, null: false
      t.references :author, null: false, index: true, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
