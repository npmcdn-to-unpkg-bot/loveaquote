class AddImageDimensionToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :image_width, :integer
    add_column :quotes, :image_height, :integer
  end
end
