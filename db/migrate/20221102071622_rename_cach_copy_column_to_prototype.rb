class RenameCachCopyColumnToPrototype < ActiveRecord::Migration[6.0]
  def change
    rename_column :prototype, :cach_copy, :catch_copy
  end
end
