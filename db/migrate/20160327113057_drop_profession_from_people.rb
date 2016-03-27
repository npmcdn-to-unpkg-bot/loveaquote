class DropProfessionFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :profession_id
  end
end
