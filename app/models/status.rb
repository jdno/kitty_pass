# To make management of servers easier, each server can be assigned a status, i.e. 'production' or 'testing'. The
# status can be used to filter or search servers. Statuses must have a unique name, and can have optionally have a
# description.
class Status < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
