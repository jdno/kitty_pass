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

  belongs_to :model
  belongs_to :status

  has_many :network_interfaces, as: :networkable, inverse_of: :networkable, dependent: :destroy

  before_save do
    hostname.downcase!
    identifier.upcase!
  end
end
