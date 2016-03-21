class AddBylineToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :byline, :string
  end
end
