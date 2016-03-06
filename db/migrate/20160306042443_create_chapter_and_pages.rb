class CreateChapterAndPages < ActiveRecord::Migration
  def change
    create_table :chapter_and_pages do |t|
      t.references :quote, index: true, null: false, foreign_key: true, on_delete: :cascade
      t.integer :chapter
      t.integer :page

      t.timestamps null: false
    end
  end
end
