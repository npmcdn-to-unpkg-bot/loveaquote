class CreateFoundAts < ActiveRecord::Migration
  def change
    create_table :found_ats do |t|
      t.string :link
      t.references :quote, index: true, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
