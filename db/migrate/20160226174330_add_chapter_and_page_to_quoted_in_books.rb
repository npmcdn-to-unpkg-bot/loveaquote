class AddChapterAndPageToQuotedInBooks < ActiveRecord::Migration
  def change
    add_column :quoted_in_books, :chapter, :integer
    add_column :quoted_in_books, :page, :integer
  end
end
