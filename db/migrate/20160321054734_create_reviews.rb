class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :source, index: true, polymorphic: true
      t.date :date

      t.timestamps null: false
    end
  end
end
