class CreateCompositions < ActiveRecord::Migration
  def change
    create_table :compositions do |t|
      t.references :person, null: false, index: true, foreign_key: true, on_delete: :cascade
      t.references :book, null: false, index: true, foreign_key: true, on_delete: :cascade
      
      t.timestamps null: false
    end
  end
end
