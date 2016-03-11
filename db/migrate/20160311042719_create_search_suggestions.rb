class CreateSearchSuggestions < ActiveRecord::Migration
  def change
    create_table :search_suggestions do |t|
      t.string :name
      t.references :source, polymorphic: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
