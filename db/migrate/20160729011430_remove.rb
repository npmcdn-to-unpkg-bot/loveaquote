class Remove < ActiveRecord::Migration
  def change
    drop_table :quote_of_the_days
    remove_column :quotes, :quote_of_the_day_count
  end
end
