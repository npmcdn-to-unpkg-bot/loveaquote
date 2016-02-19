class AddTotalShareCountToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :total_share_count, :integer, default: 0
  end
end
