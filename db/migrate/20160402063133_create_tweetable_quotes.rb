class CreateTweetableQuotes < ActiveRecord::Migration
  def change
    create_table :tweetable_quotes do |t|
      t.references :quote, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
