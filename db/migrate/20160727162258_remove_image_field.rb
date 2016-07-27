class RemoveImageField < ActiveRecord::Migration
  def change
    remove_column :books, :image
    remove_column :characters, :image
    remove_column :movies, :image
    remove_column :people, :image
    remove_column :proverbs, :image
    remove_column :topics, :image
    remove_column :tv_shows, :image
    remove_column :quotes, :image
  end
end
