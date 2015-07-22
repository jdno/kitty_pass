# The StatusesController handles the interaction with statuses. Because statuses are displayed on the settings page, the
# controller does not have the #index and #show actions.
class StatusesController < ApplicationController
  def create
    @status = Status.new status_params

    if @status.save
      flash[:success] = t 'controllers.application.create.successful', resource: 'status'
      redirect_to settings_path
    else
      flash[:error] = @status.errors.full_messages
      render 'new'
    end
  end

  def destroy
    @status = Status.find_by_id params[:id]
    return redirect_status_not_found unless @status

    if @status.destroy
      flash[:success] = t 'controllers.application.destroy.successful', resource: 'status'
    else
      flash[:error] = @status.errors.full_messages
    end

    redirect_to settings_path
  end

  def edit
    @status = Status.find_by_id params[:id]
    redirect_status_not_found unless @status
  end

  def new
  end

  def update
    @status = Status.find_by_id params[:id]
    return redirect_status_not_found unless @status

    if @status.update_attributes status_params
      flash[:success] = t 'controllers.application.update.successful', identifier: 'status'
      redirect_to settings_path
    else
      flash[:error] = @status.errors.full_messages
      redirect_to edit_status_path @status
    end
  end

  private

  def status_params
    params.require(:status).permit(:name)
  end

  def redirect_status_not_found
    flash[:error] = t 'controllers.application.access.not_found', resource: 'status'
    redirect_to settings_path
  end
end
