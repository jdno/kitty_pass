# For both Adonis and Proteus, different hardware models exist. This class represents such a model, and can be used
# to group servers by their hardware. Additionally, models can be associated with an End-of-Life date, which notes
# when support is going to end for the specific hardware version.
class Model < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: true }
end
