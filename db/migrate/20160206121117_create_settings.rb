class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.text :google_analytics
      t.string :bing_verification
      t.string :alexa_verification
      t.string :google_verification
      t.string :yandex_verification

      t.timestamps null: false
    end
  end
end
