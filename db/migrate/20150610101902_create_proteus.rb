class CreateProteus < ActiveRecord::Migration
  def change
    create_table :proteus do |t|
      t.string :hostname
      t.string :identifier
      t.string :serial_number
      t.string :inventory_number
      t.string :root_password
      t.string :ipv4_gateway
      t.string :ipv6_gateway
      t.references :model
      t.references :status

      t.timestamps null: false
    end

    add_index :proteus, :hostname,   unique: true
    add_index :proteus, :identifier, unique: true
  end
end
