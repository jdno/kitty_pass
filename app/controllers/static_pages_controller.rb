# The StaticPagesController does not control the interaction with resources, but instead provides a central
# management point to deliver static pages.
class StaticPagesController < ApplicationController
  def settings
    @models = Model.all
    @statuses = Status.all
  end
end
