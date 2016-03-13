class AddDatesToPeople < ActiveRecord::Migration
  def change
    add_column :people, :born, :date
    add_column :people, :died, :date
  end
end
