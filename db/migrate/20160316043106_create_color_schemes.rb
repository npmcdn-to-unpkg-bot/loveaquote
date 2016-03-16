class CreateColorSchemes < ActiveRecord::Migration
  def change
    create_table :color_schemes do |t|
      t.string :background_color
      t.string :foreground_color

      t.timestamps null: false
    end
  end
end
