class CreateTimeLines < ActiveRecord::Migration
  def change
    create_table :time_lines do |t|
      t.references :item, index: true, polymorphic: true, null: false

      t.timestamps null: false
    end
  end
end
