class AddAttachmentImageToTvShows < ActiveRecord::Migration
  def self.up
    change_table :tv_shows do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :tv_shows, :image
  end
end
