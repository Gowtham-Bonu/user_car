class LoginsController < ApplicationController
  skip_before_action :require_login?, only: [:new, :create]
  def new; end

  def create
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:current_user_id] = @user.id
      redirect_to cars_path, notice: "you have successfully logged in!"
    end
  end

  def destroy
    session.delete(:current_user_id)
    redirect_to new_user_path, notice: "you have successfully logged out!"
  end
end