class AddAttachmentFacebookToSocialImages < ActiveRecord::Migration
  def self.up
    change_table :social_images do |t|
      t.attachment :facebook
    end
  end

  def self.down
    remove_attachment :social_images, :facebook
  end
end
