class UpdateTweetableQuotesForeignKey < ActiveRecord::Migration
  def change
    remove_foreign_key :tweetable_quotes, :quotes
    add_foreign_key :tweetable_quotes, :quotes, on_delete: :cascade
  end
end
