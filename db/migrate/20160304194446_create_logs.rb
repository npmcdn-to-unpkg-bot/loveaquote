class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references :source, polymorphic: true, index: true
      t.string :category
      t.text :description

      t.timestamps null: false
    end
  end
end
