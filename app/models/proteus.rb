require 'ipaddress'

# Proteus are BlueCat Network's management servers, and provide the web interface to configure and manage Adonis
# servers. Proteus are identified by both an hostname and an identifier, both of which must be unique. While the
# hostname should be pretty self-explanatory, the identifier can be used to assign a unique name to a server for
# internal referencing. Depending on your organization, it can be the same as either the hostname, or the serial or
# inventory number.
#
# The serial number is assigned to a server by BlueCat, and is useful for service requests or hardware replacements.
# The inventory number is typically assigned to a server by your organization, and is optional. Additionally, the
# server's root password can be saved.
class Proteus < ActiveRecord::Base
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

  belongs_to :model
  belongs_to :status

  has_many :network_interfaces, as: :networkable, inverse_of: :networkable, dependent: :destroy

  before_save do
    hostname.downcase!
    identifier.upcase!
  end

  private

  def ipv4_gateway_has_valid_format
    return if ipv4_gateway.blank? || IPAddress.valid_ipv4?(ipv4_gateway)
    errors.add :ipv4_gateway, I18n.t('models.adonis.ipv4_gateway.invalid_format')
  end

  def ipv6_gateway_has_valid_format
    return if ipv6_gateway.blank? || IPAddress.valid_ipv6?(ipv6_gateway)
    errors.add :ipv6_gateway, I18n.t('models.adonis.ipv6_gateway.invalid_format')
  end
end
