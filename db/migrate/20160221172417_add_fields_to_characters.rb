class AddFieldsToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :published, :boolean, default: false, null: false
    add_column :characters, :popular, :boolean, default: false, null: false
    add_column :characters, :very_popular, :boolean, default: false, null: false
  end
end
