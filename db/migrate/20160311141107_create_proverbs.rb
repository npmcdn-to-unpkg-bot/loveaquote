class CreateProverbs < ActiveRecord::Migration
  def change
    create_table :proverbs do |t|
      t.string :name
      t.string :slug
      t.boolean :published
      t.boolean :popular
      t.boolean :very_popular
      t.string :image

      t.timestamps null: false
    end
  end
end
