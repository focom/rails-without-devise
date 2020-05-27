class PasswordRecoveryMailer < ActionMailer::Base
  default from: 'notifications@example.com'
  def set_password_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Reset email')
  end
end
