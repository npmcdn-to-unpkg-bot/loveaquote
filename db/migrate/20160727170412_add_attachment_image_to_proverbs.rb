class AddAttachmentImageToProverbs < ActiveRecord::Migration
  def self.up
    change_table :proverbs do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :proverbs, :image
  end
end
