class RemoveSocialImageFields < ActiveRecord::Migration
  def change
    remove_column :social_images, :twitter
    remove_column :social_images, :facebook
    remove_column :social_images, :pinterest
    remove_column :social_images, :google_plus
  end
end
