class CreateTopicAliases < ActiveRecord::Migration
  def change
    create_table :topic_aliases do |t|
      t.string :name
      t.references :topic, index: true, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
