class AddShareCountToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :twitter_share_count, :integer, default: 0
    add_column :quotes, :facebook_share_count, :integer, default: 0
    add_column :quotes, :pinterest_share_count, :integer, default: 0
    add_column :quotes, :google_plus_share_count, :integer, default: 0
  end
end
