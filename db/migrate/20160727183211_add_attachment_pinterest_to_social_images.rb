class AddAttachmentPinterestToSocialImages < ActiveRecord::Migration
  def self.up
    change_table :social_images do |t|
      t.attachment :pinterest
    end
  end

  def self.down
    remove_attachment :social_images, :pinterest
  end
end
