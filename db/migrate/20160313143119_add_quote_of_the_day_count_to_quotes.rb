class AddQuoteOfTheDayCountToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :quote_of_the_day_count, :integer, default: 0
  end
end
