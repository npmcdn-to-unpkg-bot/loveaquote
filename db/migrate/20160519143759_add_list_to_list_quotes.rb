class AddListToListQuotes < ActiveRecord::Migration
  def change
    add_column :list_quotes, :list_id, :integer, index: true, foreign_key: true, on_delete: :cascade
  end
end
