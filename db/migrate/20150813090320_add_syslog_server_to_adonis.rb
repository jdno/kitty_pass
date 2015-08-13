class AddSyslogServerToAdonis < ActiveRecord::Migration
  def change
    add_column :adonis, :syslog_server, :string
  end
end
