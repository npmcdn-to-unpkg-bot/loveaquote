class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :text
      t.references :source, polymorphic: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
