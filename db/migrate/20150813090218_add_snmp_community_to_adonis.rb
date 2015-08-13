class AddSNMPCommunityToAdonis < ActiveRecord::Migration
  def change
    add_column :adonis, :snmp_community, :string
  end
end
