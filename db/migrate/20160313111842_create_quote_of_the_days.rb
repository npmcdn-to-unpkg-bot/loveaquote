class CreateQuoteOfTheDays < ActiveRecord::Migration
  def change
    create_table :quote_of_the_days do |t|
      t.date :date
      t.references :quote, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
