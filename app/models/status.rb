# To make management of servers easier, each server can be assigned a status, i.e. 'production' or 'testing'. The
# status can be used to filter or search servers. What kinds of statuses are available depends on the user.
class Status < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
