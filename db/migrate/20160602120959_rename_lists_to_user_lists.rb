class RenameListsToUserLists < ActiveRecord::Migration
  def change
    rename_table :lists, :user_lists
  end
end
