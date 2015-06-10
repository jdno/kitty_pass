class CreateNetworkInterfaces < ActiveRecord::Migration
  def change
    create_table :network_interfaces do |t|
      t.string :name
      t.string :mac_address
      t.string :ipv4_address
      t.string :ipv4_netmask
      t.string :ipv6_address
      t.integer :ipv6_prefix
      t.integer :networkable_id
      t.string  :networkable_type

      t.timestamps null: false
    end

    add_index :network_interfaces, [:name, :networkable_id, :networkable_type],
              unique: true, name: 'index_network_interfaces'
  end
end
