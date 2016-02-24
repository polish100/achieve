class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook

    if request.env["omniauth.auth"].info.email.blank?
        return redirect_to new_user_session_url, notice: 'Facebookのメールアドレスを提供する設定にしてください！'
    end

   if  User.where.not(provider: "facebook").where(email: request.env["omniauth.auth"].info.email).present? then
         return redirect_to new_user_session_url, notice: 'Facebookと同じメールアドレスがすでに登録されています！メールアドレスでログインしてください！'
     end

    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end

  end

  def twitter
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)
    logger.debug"--------------------------------------------"
    logger.debug(@user.inspect)
    logger.debug"--------------------------------------------"
    if @user.persisted?
      set_flash_message(:notice, :success, kind: "Twitter")  if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end

  end

end
