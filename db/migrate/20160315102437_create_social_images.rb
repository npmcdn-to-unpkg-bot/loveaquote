class CreateSocialImages < ActiveRecord::Migration
  def change
    create_table :social_images do |t|
      t.references :source, index: true, polymorphic: true, null: false
      t.string :twitter
      t.string :facebook
      t.string :google_plus

      t.timestamps null: false
    end
  end
end
