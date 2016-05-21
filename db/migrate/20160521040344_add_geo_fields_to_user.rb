class AddGeoFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :state_code, :string
    add_column :users, :country, :string
    add_column :users, :country_code, :string
  end
end
