class RenameListQuotesToUserQuotes < ActiveRecord::Migration
  def change
    rename_column :list_quotes, :list_id, :user_id
    rename_table :list_quotes, :user_quotes
  end
end
