class AddUserMarkForDeletion < ActiveRecord::Migration
  def change
    add_column :users, :mark_for_deletion, :boolean, default: false
  end
end
