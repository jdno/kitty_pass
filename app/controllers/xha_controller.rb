# This controller handles the interaction with XHA. Because XHA are displayed on the page of their respective
# server's, the usual #index and #show actions are missing.
class XHAController < ApplicationController
  def create
    @xha = XHA.new xha_params

    if @xha.save
      flash[:success] = t 'controllers.application.create.successful', resource: 'XHA'
      redirect_to adonis_path @xha.master
    else
      flash[:error] = @xha.errors.full_messages
      render :new
    end
  end

  def destroy
    @xha = XHA.find_by_id params[:id]
    return redirect_xha_not_found unless @xha

    if @xha.destroy
      flash[:success] = t 'controllers.application.destroy.successful', resource: 'XHA'
      redirect_to adonis_path @xha.master
    else
      flash[:error] = @xha.errors.full_messages
      redirect_to adonis_path @xha.master
    end
  end

  def edit
    @xha = XHA.find_by_id params[:id]
    redirect_xha_not_found unless @xha
  end

  def new
  end

  def update
    @xha = XHA.find_by_id params[:id]
    return redirect_xha_not_found unless @xha

    if @xha.update_attributes xha_params
      flash[:success] = t 'controllers.application.update.successful', identifier: 'XHA'
      redirect_to adonis_path @xha.master
    else
      flash[:error] = @xha.errors.full_messages
      redirect_to edit_xha_path @xha
    end
  end

  private

  def redirect_xha_not_found
    flash[:error] = t 'controllers.application.access.not_found', resource: 'XHA'
    redirect_to adonis_index_path
  end

  def xha_params
    params.require(:xha).permit(:master_id, :slave_id)
  end
end
