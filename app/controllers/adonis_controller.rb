# This controller controls the interaction with Adonis servers. It has the default actions every Rails controller
# has: index, show, edit, update, new, create.
class AdonisController < ApplicationController
  def create
    @adonis = Adonis.new adonis_params

    if @adonis.save
      flash[:success] = t 'controllers.application.create.successful', resource: 'Adonis'
      redirect_to adonis_path @adonis
    else
      flash[:error] = @adonis.errors.full_messages
      render :new
    end
  end

  def destroy
    @adonis = Adonis.find_by_id params[:id]
    return redirect_adonis_not_found unless @adonis

    if @adonis.destroy
      flash[:success] = t 'controllers.application.destroy.successful', resource: 'Adonis'
      redirect_to adonis_index_path
    else
      flash[:error] = @adonis.errors.full_messages
      redirect_to adonis_path @adonis
    end
  end

  def edit
    @adonis = Adonis.find_by_id params[:id]
    redirect_adonis_not_found unless @adonis
  end

  def index
    @adonis = Adonis.filter(params.slice(:model_id, :location_id, :status_id))
  end

  def new
  end

  def show
    @adonis = Adonis.find_by_id params[:id]
    redirect_adonis_not_found unless @adonis
  end

  def update
    @adonis = Adonis.find_by_id params[:id]
    return redirect_adonis_not_found unless @adonis

    if @adonis.update_attributes adonis_params
      flash[:success] = t 'controllers.application.update.successful', identifier: @adonis.hostname
      redirect_to adonis_path @adonis
    else
      flash[:error] = @adonis.errors.full_messages
      redirect_to edit_adonis_path @adonis
    end
  end

  private

  def adonis_params
    params.require(:adonis).permit(:admin_password, :deploy_password, :hostname, :identifier, :inventory_number,
                                   :ipv4_gateway, :ipv6_gateway, :location_id, :model_id, :root_password,
                                   :serial_number, :status_id)
  end

  def redirect_adonis_not_found
    flash[:error] = t 'controllers.application.access.not_found', resource: 'Adonis'
    redirect_to adonis_index_path
  end
end
