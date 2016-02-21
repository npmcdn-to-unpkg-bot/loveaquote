class RenameAuthorsToPeople < ActiveRecord::Migration
  def change
    rename_table :authors, :people
    rename_column :books, :author_id, :person_id
  end
end
