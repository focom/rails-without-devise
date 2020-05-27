# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_creation_params)
    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_now
      session[:user] = @user
      redirect_to(@user, notice: 'User was successfully created.')
    else
      render :new
    end
  end

  def edit
    if session[:user].present?
      @user = User.find(session[:user]['id'])
    else
      flash[:notice] = 'Login to reach this page'
      redirect_to root_path
    end
  end

  def update
    @user = User.find(session[:user]['id'])
    @user.update(user_update_params)
    render 'edit'
  end

  def signin
    @user = User.find_by(email: params[:email])
    return redirect_to(login_path, notice: 'Wrong credential') unless @user
    return redirect_to(login_path, notice: 'Wrong credential') unless @user.authenticate(params[:password])

    session[:user] = @user
    redirect_to(@user, notice: 'Succesful login')
  end

  def login; end

  def logout
    reset_session
    redirect_to login_path
  end

  private

  def user_creation_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
