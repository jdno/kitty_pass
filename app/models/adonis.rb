require 'ipaddress'

# Adonis are BlueCat Network's DHCP/DNS server, and are typically the most common server type. Adonis are identified
# by both an hostname and an identifier, both of which must be unique. While the hostname should be pretty
# self-explanatory, the identifier can be used to assign a unique name to a server for internal referencing.
# Depending on your organization, it can be the same as either the hostname, or the serial or inventory number.
#
# The serial number is assigned to a server by BlueCat, and is useful for service requests or hardware replacements.
# The inventory number is typically assigned to a server by your organization, and is optional.
# Three password fields exist, one for the root account, the admin account and one for the deploy account.
class Adonis < ActiveRecord::Base
  HOSTNAME_REGEX = /\A[a-z0-9\-\.]*\z/i
  IDENTIFIER_REGEX = /\A.*\z/i

  validates :hostname,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: HOSTNAME_REGEX }
  validates :identifier,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: IDENTIFIER_REGEX }
  validates :root_password,
            presence: true

  validate :ipv4_gateway_has_valid_format, :ipv6_gateway_has_valid_format

  belongs_to :location, inverse_of: :adonis
  belongs_to :model, inverse_of: :adonis
  belongs_to :status, inverse_of: :adonis

  has_many :network_interfaces, as: :networkable, inverse_of: :networkable, dependent: :destroy

  before_save do
    hostname.downcase!
    identifier.upcase!
  end

  private

  def ipv4_gateway_has_valid_format
    return if ipv4_gateway.blank? || IPAddress.valid_ipv4?(ipv4_gateway)
    errors.add :ipv4_gateway, I18n.t('models.application.invalid_format',
                                     attribute: I18n.t('models.adonis.ipv4_gateway'),
                                     expected: '192.168.1.1')
  end

  def ipv6_gateway_has_valid_format
    return if ipv6_gateway.blank? || IPAddress.valid_ipv6?(ipv6_gateway)
    errors.add :ipv6_gateway, I18n.t('models.application.invalid_format',
                                     attribute: I18n.t('models.adonis.ipv6_gateway'),
                                     expected: 'ac5f:d696:3807:1d72::7d2b:e1df')
  end
end
