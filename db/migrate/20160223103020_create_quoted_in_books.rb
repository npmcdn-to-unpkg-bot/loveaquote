class CreateQuotedInBooks < ActiveRecord::Migration
  def change
    create_table :quoted_in_books do |t|
      t.string :name
      t.string :author
      t.references :quote, null: false, index: true, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
