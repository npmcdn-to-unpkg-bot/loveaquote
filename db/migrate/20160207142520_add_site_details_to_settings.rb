class AddSiteDetailsToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :title, :string
    add_column :settings, :description, :text
    add_column :settings, :facebook_url, :string
    add_column :settings, :twitter_url, :string
    add_column :settings, :google_plus_url, :string
    add_column :settings, :pinterest_url, :string
  end
end
