class AddSubCategoryToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :sub_category, :string
  end
end
