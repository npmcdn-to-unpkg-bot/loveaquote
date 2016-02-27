class CreateNationalities < ActiveRecord::Migration
  def change
    create_table :nationalities do |t|
      t.string :name
      t.timestamps null: false
    end
    add_column :people, :nationality_id, :integer, index: true
  end
end
