class Users::RegistrationsController < Devise::RegistrationsController

before_action :additional_task, only: [:create]

  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end


  def create
    super
  end

  private

    def additional_task
       if User.where(provider: "facebook").where(email: user_params[:email]).present?
           return redirect_to new_user_session_url, notice: 'このメールアドレスはfacebook認証ですでに使われています！facebook認証でログインしてください！'
        end
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
