class UpdateForeignKeyQuotesCharacter < ActiveRecord::Migration
  def change
    remove_foreign_key :quotes, :characters
    add_foreign_key :quotes, :characters, on_delete: :nullify
  end
end
