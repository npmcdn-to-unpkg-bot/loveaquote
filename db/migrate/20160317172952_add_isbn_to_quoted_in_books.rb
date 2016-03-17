class AddIsbnToQuotedInBooks < ActiveRecord::Migration
  def change
    add_column :quoted_in_books, :isbn, :string
  end
end
