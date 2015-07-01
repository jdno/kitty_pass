class AddLocationToAdonis < ActiveRecord::Migration
  def change
    add_reference :adonis, :location
  end
end
