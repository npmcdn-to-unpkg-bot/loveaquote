class AddFieldsToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :first_name, :string
    add_column :identities, :last_name, :string
    add_column :identities, :image, :string
    add_column :identities, :gender, :string
    add_column :identities, :profile, :string
  end
end
