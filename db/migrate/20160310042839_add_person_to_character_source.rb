class AddPersonToCharacterSource < ActiveRecord::Migration
  def change
    add_reference :character_sources, :person, index: true, foreign_key: true, on_delete: :nullify
  end
end
