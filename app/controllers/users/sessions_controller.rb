class Users::SessionsController < Devise::SessionsController

  before_action :additional_task, only: [:create]

  def create
    super
  end

  private

    def additional_task
          logger.debug"--------------------------------------------"
    logger.debug(User.where(provider: "facebook").where(email: user_params[:email]))
    logger.debug"--------------------------------------------"
       if User.where(provider: "facebook").where(email: user_params[:email]).present?
           return redirect_to new_user_session_url, notice: 'このメールアドレスはfacebook認証ですでに使われています！facebook認証でログインしてください！'
        end
    end

    def user_params
      params.require(:user).permit(:email, :password, :remember_me)
    end
end
