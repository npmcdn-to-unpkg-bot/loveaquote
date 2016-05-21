class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_google_oauth2(request.env["omniauth.auth"])
    if @user.persisted?
      UserAddGeoipDataWorker.perform_async(@user.id, request.remote_ip) unless @user.city.present? && @user.country.present?
      sign_in_and_redirect @user
    else
      redirect_to root_url
    end
  end
  
  def facebook
    @user = User.from_facebook(request.env["omniauth.auth"])
    if @user.persisted?
      UserAddGeoipDataWorker.perform_async(@user.id, request.remote_ip) unless @user.city.present? && @user.country.present?
      sign_in_and_redirect @user
    else
      redirect_to root_url
    end    
  end
end
