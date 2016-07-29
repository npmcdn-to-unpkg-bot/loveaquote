class My::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_google_oauth2(request.env["omniauth.auth"])
    if @user.persisted?
      Delayed::Job.enqueue UserGeoipDataJob.new(@user.id, request.remote_ip)
      Delayed::Job.enqueue UserAddAsSubscriber.new(@user.id, request.remote_ip)
      sign_in @user
      redirect_to after_sign_in_path_for(@user), notice: "You are now logged in"
    else
      redirect_to root_url
    end
  end
  
  def facebook
    @user = User.from_facebook(request.env["omniauth.auth"])
    if @user.persisted?
      Delayed::Job.enqueue UserGeoipDataJob.new(@user.id, request.remote_ip)      
      Delayed::Job.enqueue UserAddAsSubscriber.new(@user.id, request.remote_ip)
      sign_in @user
      redirect_to after_sign_in_path_for(@user), notice: "You are now logged in"
    else
      redirect_to root_url
    end    
  end
end