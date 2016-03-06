class CreateSeasonAndEpisodes < ActiveRecord::Migration
  def change
    create_table :season_and_episodes do |t|
      t.references :quote, index: true, null: false, foreign_key: true, on_delete: :cascade
      t.integer :season
      t.integer :episode

      t.timestamps null: false
    end
  end
end
