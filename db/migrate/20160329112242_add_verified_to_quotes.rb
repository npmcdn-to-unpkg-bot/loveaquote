class AddVerifiedToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :verified, :boolean, default: false
  end
end
