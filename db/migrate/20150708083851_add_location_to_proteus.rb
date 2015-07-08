class AddLocationToProteus < ActiveRecord::Migration
  def change
    add_reference :proteus, :location
  end
end
