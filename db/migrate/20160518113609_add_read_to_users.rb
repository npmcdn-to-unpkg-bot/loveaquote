class AddReadToUsers < ActiveRecord::Migration
  def change
    add_column :users, :read, :boolean, default: false
  end
end
