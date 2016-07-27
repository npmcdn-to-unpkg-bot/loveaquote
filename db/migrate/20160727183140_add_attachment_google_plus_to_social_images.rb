class AddAttachmentGooglePlusToSocialImages < ActiveRecord::Migration
  def self.up
    change_table :social_images do |t|
      t.attachment :google_plus
    end
  end

  def self.down
    remove_attachment :social_images, :google_plus
  end
end
