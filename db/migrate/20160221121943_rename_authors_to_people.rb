class RenameAuthorsToPeople < ActiveRecord::Migration
  def change
    rename_table :authors, :people
    rename_column :books, :author_id, :person_id
    rename_index :people, :index_authors_on_slug, :index_people_on_slug
    rename_index :books, :index_books_on_author_id, :index_books_on_person_id
  end
end
