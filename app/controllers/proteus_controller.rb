# The ProteusController handles the interaction with Proteus servers. It has the default actions all Rails controller
# have.
class ProteusController < ApplicationController
  def create
    @proteus = Proteus.new proteus_params

    if @proteus.save
      flash[:success] = t 'controllers.application.create.successful', resource: 'Proteus'
      redirect_to proteus_path @proteus
    else
      flash[:error] = @proteus.errors.full_messages
      render :new
    end
  end

  def destroy
    @proteus = Proteus.find_by_id params[:id]
    return redirect_proteus_not_found unless @proteus

    if @proteus.destroy
      flash[:success] = t 'controllers.application.destroy.successful', resource: 'Proteus'
      redirect_to proteus_index_path
    else
      flash[:error] = @proteus.errors.full_messages
      redirect_to proteus_path @proteus
    end
  end

  def edit
    @proteus = Proteus.find_by_id params[:id]
    redirect_proteus_not_found unless @proteus
  end

  def index
    @proteus = Proteus.all
  end

  def new
  end

  def show
    @proteus = Proteus.find_by_id params[:id]
    redirect_proteus_not_found unless @proteus
  end

  def update
    @proteus = Proteus.find_by_id params[:id]
    return redirect_proteus_not_found unless @proteus

    if @proteus.update_attributes proteus_params
      flash[:success] = t 'controllers.application.update.successful', identifier: @proteus.hostname
      redirect_to proteus_path @proteus
    else
      flash[:error] = @proteus.errors.full_messages
      redirect_to edit_proteus_path @proteus
    end
  end

  private

  def proteus_params
    params.require(:proteus).permit(:hostname, :identifier, :inventory_number, :ipv4_gateway, :ipv6_gateway,
                                    :model_id, :root_password, :serial_number, :status_id)
  end

  def redirect_proteus_not_found
    flash[:error] = t 'controllers.application.access.not_found', resource: 'Proteus'
    redirect_to proteus_index_path
  end
end
