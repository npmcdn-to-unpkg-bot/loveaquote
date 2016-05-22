class AddMoreFieldsToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :verified, :boolean, default: false
    add_column :subscribers, :time_zone, :string
    add_column :subscribers, :first_name, :string
    add_column :subscribers, :last_name, :string
  end
end
