class CreateQuoteTopicSuggestions < ActiveRecord::Migration
  def change
    create_table :quote_topic_suggestions do |t|
      t.references :quote, index: true
      t.references :topic, index: true
      t.boolean :read, default: false, null:false
      
      t.timestamps null: false
    end
  end
end
