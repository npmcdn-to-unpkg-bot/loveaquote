class CreateQuoteTopics < ActiveRecord::Migration
  def change
    create_table :quote_topics do |t|
      t.references :quote, index: true, null: false, foreign_key: true, on_delete: :cascade
      t.references :topic, index: true, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
