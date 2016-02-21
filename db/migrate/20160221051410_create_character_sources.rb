class CreateCharacterSources < ActiveRecord::Migration
  def change
    create_table :character_sources do |t|
      t.references :character, null: false, index: true, foreign_key: true, on_delete: :cascade
      t.references :source, polymorphic: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
