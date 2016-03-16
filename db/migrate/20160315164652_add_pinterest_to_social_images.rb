class AddPinterestToSocialImages < ActiveRecord::Migration
  def change
    add_column :social_images, :pinterest, :string
  end
end
