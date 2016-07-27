class AddAttachmentTwitterToSocialImages < ActiveRecord::Migration
  def self.up
    change_table :social_images do |t|
      t.attachment :twitter
    end
  end

  def self.down
    remove_attachment :social_images, :twitter
  end
end
