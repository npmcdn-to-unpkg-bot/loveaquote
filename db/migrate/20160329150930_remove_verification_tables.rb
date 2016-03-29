class RemoveVerificationTables < ActiveRecord::Migration
  def change
    drop_table :found_ats
    drop_table :season_and_episodes
    drop_table :quoted_in_books
    drop_table :chapter_and_pages
  end
end
