class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_from :facebook
  end

  def google_oauth2
    callback_from :google
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    session[:nickname] = @user.nickname
    session[:email] = @user.email
    session[:password] = @user.password
    session[:provider] = @user.provider
    session[:uid] = @user.uid
    if @user.persisted?
      redirect_to signup_registration_path(@user)
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
    else
      redirect_to signup_registration_path
      session[:nickname] = @user.nickname
      session[:email] = @user.email
      session[:password] = @user.password
      session[:provider] = @user.provider
      session[:uid] = @user.uid
    end
  end
end
