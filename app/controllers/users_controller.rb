class UsersController < ApplicationController
  skip_before_action :require_login?

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to cars_path, notice: "welcome!"
    else
      flash.now[:error] = "action invalid!"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end