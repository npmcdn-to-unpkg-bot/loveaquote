class CreateQuoteTopics < ActiveRecord::Migration
  def change
    create_table :quote_topics do |t|
      t.references :quote, index: true
      t.references :topic, index: true

      t.timestamps null: false
    end
  end
end
