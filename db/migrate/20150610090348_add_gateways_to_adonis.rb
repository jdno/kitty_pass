class AddGatewaysToAdonis < ActiveRecord::Migration
  def change
    add_column :adonis, :ipv4_gateway, :string
    add_column :adonis, :ipv6_gateway, :string
  end
end
