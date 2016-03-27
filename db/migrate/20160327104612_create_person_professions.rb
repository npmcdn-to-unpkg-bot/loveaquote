class CreatePersonProfessions < ActiveRecord::Migration
  def change
    create_table :person_professions do |t|
      t.references :person, index: true, foreign_key: true, on_delete: :cascade
      t.references :profession, index: true, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
