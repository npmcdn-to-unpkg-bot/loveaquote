class CreateSeos < ActiveRecord::Migration
  def change
    create_table :seos do |t|
      t.string :title
      t.text :description
      t.references :source, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
