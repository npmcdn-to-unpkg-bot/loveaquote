class CreateMyQuotes < ActiveRecord::Migration
  def change
    create_table :my_quotes do |t|
      t.references :user, index: true, foreign_key: true, on_delete: :cascade
      t.references :quote, index: true, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
