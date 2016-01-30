class CreateQuoteTopicSuggestions < ActiveRecord::Migration
  def change
    create_table :quote_topic_suggestions do |t|
      t.references :quote, index: true, null: false, foreign_key: true, on_delete: :cascade
      t.references :topic, index: true, null: false, foreign_key: true, on_delete: :cascade
      t.boolean :read, default: false, null:false
      
      t.timestamps null: false
    end
  end
end
