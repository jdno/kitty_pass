# This controller handles the interaction with network intefaces. Because network intefaces are displayed on the
# servers' pages, the controller does not have the #index and #show actions.
class NetworkInterfacesController < ApplicationController
  def create
    initialize_networkable_or_redirect && return unless @networkable

    @network_interface = NetworkInterface.new network_interface_params
    @network_interface.networkable = @networkable

    if @network_interface.save
      flash[:success] = t 'controllers.application.create.successful', resource: t('models.adonis.network_interface')
      redirect_networkable
    else
      flash[:error] = @network_interface.errors.full_messages
      render :new
    end
  end

  def destroy
    @network_interface = NetworkInterface.find_by_id params[:id]
    return redirect_network_interface_not_found unless @network_interface

    if @network_interface.destroy
      flash[:success] = t 'controllers.application.destroy.successful', resource: t('models.adonis.network_interface')
    else
      flash[:error] = @network_interface.errors.full_messages
    end

    redirect_networkable
  end

  def edit
    @network_interface = NetworkInterface.includes(:networkable).find_by_id params[:id]
    return redirect_network_interface_not_found unless @network_interface
  end

  def new
    initialize_networkable_or_redirect && return unless @networkable
    @network_interface = NetworkInterface.new(networkable: @networkable)
  end

  def update
    @network_interface = NetworkInterface.includes(:networkable).find_by_id params[:id]
    return redirect_network_interface_not_found unless @network_interface

    if @network_interface.update_attributes network_interface_params
      flash[:success] = t 'controllers.application.update.successful', identifier: @network_interface.name
      redirect_networkable
    else
      flash[:error] = @network_interface.errors.full_messages
      redirect_to edit_network_interface_path @network_interface
    end
  end

  private

  def initialize_networkable_or_redirect
    @networkable = Adonis.find_by_id(params[:adonis_id]) || Proteus.find_by_id(params[:proteus_id]) ||
                   XHA.find_by_id(params[:xha_id])
    redirect_networkable_not_found unless @networkable
  end

  def network_interface_params
    params.require(:network_interface).permit(:ipv4_address, :ipv4_netmask, :ipv6_address, :ipv6_prefix,
                                              :mac_address, :name, :networkable_id, :networkable_type)
  end

  def redirect_network_interface_not_found
    flash[:error] = t 'controllers.application.access.not_found', resource: t('models.adonis.network_interface')
    redirect_to request.referer || root_path
  end

  def redirect_networkable
    case @network_interface.networkable_type
    when 'Adonis'
      redirect_to adonis_path @network_interface.networkable
    when 'Proteus'
      redirect_to proteus_path @network_interface.networkable
    when 'XHA'
      redirect_to adonis_path @network_interface.networkable.master
    else
      redirect_networkable_not_found
    end
  end

  def redirect_networkable_not_found
    flash[:error] = t 'controllers.application.access.not_found', resource: t('views.application.server')
    redirect_to root_path
  end
end
