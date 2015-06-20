# The ModelsController handles the interaction with models. Because models are displayed on the settings page, the
# controller does not have the #index and #show actions.
class ModelsController < ApplicationController
  def create
    @model = Model.new model_params

    if @model.save
      flash[:success] = t 'controllers.application.create.successful', resource: 'model'
      redirect_to settings_path
    else
      flash[:error] = @model.errors.full_messages
      render 'new'
    end
  end

  def destroy
    @model = Model.find_by_id params[:id]
    return redirect_model_not_found unless @model

    if @model.destroy
      flash[:success] = t 'controllers.application.destroy.successful', resource: 'model'
    else
      flash[:error] = @model.errors.full_messages
    end

    redirect_to settings_path
  end

  def edit
    @model = Model.find_by_id params[:id]
    redirect_model_not_found unless @model
  end

  def new
  end

  def update
    @model = Model.find_by_id params[:id]
    return redirect_model_not_found unless @model

    if @model.update_attributes model_params
      flash[:success] = t 'controllers.application.update.successful', identifier: @model.name
      redirect_to settings_path
    else
      flash[:error] = @model.errors.full_messages
      redirect_to edit_model_path @model
    end
  end

  private

  def model_params
    params.require(:model).permit(:name, :eol)
  end

  def redirect_model_not_found
    flash[:error] = t 'controllers.application.access.not_found', resource: 'model'
    redirect_to settings_path
  end
end
