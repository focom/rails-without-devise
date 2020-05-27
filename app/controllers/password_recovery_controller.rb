# frozen_string_literal: true

class PasswordRecoveryController < ApplicationController
  def index; end

  def send_reset_email
    user = User.find_by(email: reset_email_params[:email])
    if user.blank?
      flash[:notice] = 'No account with this email'
    else
      token = SecureRandom.uuid
      user.update_attributes!(reset_password_token: token, reset_password_sent_at: Time.now)
      PasswordRecoveryMailer.with(user: user).set_password_email.deliver_now
      flash[:notice] = 'Email sent'
      return render :index
    end
    redirect_to login_path
  end

  def verify_token
    @user = User.find_by(reset_password_token: params[:reset_password_token])
    return redirect_to(root_path, notice: 'Invalid code') unless @user
  end

  def set_password
    verify_token
    @user = User.new
  end

  def update_password
    verify_token
    if (Time.now - (@user.reset_password_sent_at + 6.hours)).negative?
      if @user.update_attributes(update_password_params.merge(reset_password_token: ''))
        return redirect_to login_path, notice: 'Password has been reset, you can now login'
      end

      return render 'set_password'
    end
    redirect_to root_path, notice: 'Code expired'
  end
end

private

def reset_email_params
  params.permit(:email)
end

def update_password_params
  params.require(:user).permit(:password, :password_confirmation)
end
