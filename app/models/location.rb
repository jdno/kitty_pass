# A location is the highest hierarchical level on which servers can be grouped. Every location has a unique name, which
# must follow certain rules regarding its characters (see Location::NAME_REGEX) and length (see Location::NAME_LENGTH).
# By default, the characters are restricted to letters, numbers, underscore and whitespace, and the length must be
# within three and 16 characters.
class Location < ActiveRecord::Base
  NAME_REGEX = /\A[\w\s]*\z/i
  NAME_LENGTH = 3..16

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { in: NAME_LENGTH },
            format: { with: NAME_REGEX }
end
