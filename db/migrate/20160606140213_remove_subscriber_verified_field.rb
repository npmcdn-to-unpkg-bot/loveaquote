class RemoveSubscriberVerifiedField < ActiveRecord::Migration
  def change
    remove_column :subscribers, :verified, :boolean
  end
end
