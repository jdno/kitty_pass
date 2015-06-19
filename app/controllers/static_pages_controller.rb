class StaticPagesController < ApplicationController
  def settings
    @models = Model.all
    @statuses = Status.all
  end
end
