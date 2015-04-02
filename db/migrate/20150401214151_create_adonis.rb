class CreateAdonis < ActiveRecord::Migration
  def change
    create_table :adonis do |t|
      t.string :hostname
      t.string :identifier
      t.string :serial_number
      t.string :inventory_number
      t.string :root_password
      t.string :admin_password
      t.string :deploy_password

      t.timestamps null: false
    end

    add_index :adonis, :hostname,   unique: true
    add_index :adonis, :identifier, unique: true
  end
end
