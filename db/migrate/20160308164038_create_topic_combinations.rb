class CreateTopicCombinations < ActiveRecord::Migration
  def change
    create_table :topic_combinations do |t|
      t.integer :primary_topic_id, index: true, null: false
      t.integer :secondary_topic_id, index: true, null: false
      t.string :slug

      t.timestamps null: false
    end
    
    add_foreign_key :topic_combinations, :topics, column: :primary_topic_id, on_delete: :cascade
    add_foreign_key :topic_combinations, :topics, column: :secondary_topic_id, on_delete: :cascade
  end
end
