class AddModelToAdonis < ActiveRecord::Migration
  def change
    add_reference :adonis, :models
  end
end
