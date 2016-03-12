class CreateUserSearches < ActiveRecord::Migration
  def change
    create_table :user_searches do |t|
      t.string :text
      t.references :source, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
