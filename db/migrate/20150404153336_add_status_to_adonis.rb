class AddStatusToAdonis < ActiveRecord::Migration
  def change
    add_reference :adonis, :statuses
  end
end
