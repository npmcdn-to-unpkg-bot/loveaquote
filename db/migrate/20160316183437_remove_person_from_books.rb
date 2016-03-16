class RemovePersonFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :person_id, :integer
  end
end
