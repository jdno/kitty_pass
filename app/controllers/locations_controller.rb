# The LocationController handles the interaction with locations.
class LocationsController < ApplicationController
  def create
    @location = Location.new location_params

    if @location.save
      flash[:success] = t 'controllers.application.create.successful', resource: t('models.adonis.location')
      redirect_to location_path @location
    else
      flash[:error] = @location.errors.full_messages
      render :new
    end
  end

  def destroy
    @location = Location.find_by_id params[:id]
    return redirect_location_not_found unless @location

    if @location.destroy
      flash[:success] = t 'controllers.application.destroy.successful', resource: t('models.adonis.location')
      redirect_to locations_path
    else
      flash[:error] = @location.errors.full_messages
      redirect_to location_path @location
    end
  end

  def edit
    @location = Location.find_by_id params[:id]
    redirect_location_not_found unless @location
  end

  def index
    @locations = Location.all
  end

  def new
  end

  def show
    @location = Location.find_by_id params[:id]
    redirect_location_not_found unless @location
  end

  def update
    @location = Location.find_by_id params[:id]
    return redirect_location_not_found unless @location

    if @location.update_attributes location_params
      flash[:success] = t 'controllers.application.update.successful', identifier: @location.name
      redirect_to location_path @location
    else
      flash[:error] = @location.errors.full_messages
      redirect_to edit_location_path @location
    end
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end

  def redirect_location_not_found
    flash[:error] = t 'controllers.application.access.not_found', resource: t('models.adonis.location')
    redirect_to locations_path
  end
end
