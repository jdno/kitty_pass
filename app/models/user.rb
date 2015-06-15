# This class represents the users of this application. Every user is identified by its name and email address, and has a
# password. Authentication is done via devise, whose modules have been configured to provide a reliable and
# secure basis.
class User < ActiveRecord::Base
  devise :database_authenticatable, # encrypts and stores a password in the database
         :confirmable,              # sends emails with confirmation instructions
         :lockable,                 # locks an account after a specified number of failed sign-in attempts
         :recoverable,              # resets the user password and sends reset instructions
         :registerable,             # handles signing up users through a registration process
         :timeoutable,              # expires sessions that have not been active in a specified period of time
         :trackable,                # tracks sign in count, timestamps and IP address
         :validatable               # provides validations of email and password

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
