class RenameXHATable < ActiveRecord::Migration
  def change
    rename_table :xhas, :xha
  end
end
