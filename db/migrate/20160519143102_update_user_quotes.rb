class UpdateUserQuotes < ActiveRecord::Migration
  def change
    remove_column :my_quotes, :user_id
    rename_table :my_quotes, :list_quotes
  end
end
