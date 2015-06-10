require 'ipaddress'

# Network interfaces belong to a server, and are identified by their name, which must be unique in the scope of
# the server. They have an IPv4 and an IPv6 address as well as a MAC address, which are all validates before save.
class NetworkInterface < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { scope: :networkable, case_sensitive: false }
  validates :mac_address, format: { with: /\A([0-9A-F]{2}[:-]){5}([0-9A-F]{2})\z/i }
  validates :ipv6_prefix, inclusion: { in: 0..128 }

  validate :validate_ipv4_address,
           :validate_ipv4_netmask,
           :validate_ipv6_address

  belongs_to :networkable, polymorphic: true, inverse_of: :network_interfaces

  private

  def validate_ipv4_address
    return if IPAddress.valid_ipv4? ipv4_address
    errors.add :ipv4_address, I18n.t('network_interface.ipv4_address.invalid_format')
  end

  def validate_ipv4_netmask
    return if IPAddress.valid_ipv4_netmask? ipv4_netmask
    errors.add :ipv4_netmask, I18n.t('network_interface.ipv4_netmask.invalid_format')
  end

  def validate_ipv6_address
    return if IPAddress.valid_ipv6? ipv6_address
    errors.add :ipv6_address, I18n.t('network_interface.ipv6_address.invalid_format')
  end
end
