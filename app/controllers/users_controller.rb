# The UsersController provides the #index action for users. All other interaction with the User resource is handled
# by devise.
class UsersController < ApplicationController
  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t 'controllers.application.create.successful', resource: t('views.application.user')
      redirect_to users_path
    else
      flash[:error] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find_by_id params[:id]
    return redirect_user_not_found unless @user

    if @user.destroy
      flash[:success] = t 'controllers.application.destroy.successful', resource: t('views.application.user')
      redirect_to users_path
    else
      flash[:error] = @user.errors.full_messages
      redirect_to users_path
    end
  end

  def index
    @users = User.all
  end

  def new
  end

  private

  def redirect_user_not_found
    flash[:error] = t 'controllers.application.access.not_found', resource: t('views.application.user')
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
