class CreateUserQuoteUserLists < ActiveRecord::Migration
  def change
    create_table :user_quote_user_lists do |t|
      t.references :user_quote, index: true, null: false, foreign_key: true, on_delete: :cascade
      t.references :user_list, index: true, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
