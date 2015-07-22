class ChangeColumnNameForAdonis < ActiveRecord::Migration
  def change
    rename_column :adonis, :models_id, :model_id
    rename_column :adonis, :statuses_id, :status_id
  end
end
