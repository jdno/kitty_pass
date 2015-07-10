# The StaticPagesController does not control the interaction with resources, but instead provides a central
# management point to deliver static pages.
class StaticPagesController < ApplicationController
  def settings
    @models = Model.all
    @statuses = Status.all
  end

  def statistics
    @adonis_count = Adonis.count
    @proteus_count = Proteus.count

    @user_count = User.count

    @models = Model.all
    @statuses = Status.all
  end
end
