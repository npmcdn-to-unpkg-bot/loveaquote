class CreateCharacterSources < ActiveRecord::Migration
  def change
    create_table :character_sources do |t|
      t.references :character, index: true, foreign_key: true
      t.references :source, polymorphic: true,index: true

      t.timestamps null: false
    end
  end
end
