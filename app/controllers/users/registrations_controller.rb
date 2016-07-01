class Users::RegistrationsController < Devise::RegistrationsController

#before_action :additional_task, only: [:create]
#after_action :image_operation, only: [:update]

  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
#    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :name, :password, :password_confirmation, :current_password,:image , :remove_image)
    end
  end

  def create
    super
  end

  def update
      logger.debug"--------------------------------------------"
      logger.debug"update_test1"
      logger.debug(user_params[:current_password])
      logger.debug(user_params[:password].to_s)
      logger.debug(user_params[:password].to_s.length)
      logger.debug(user_params[:password_confirmation].to_s)
      logger.debug(user_params[:password_confirmation].to_s.length)
      logger.debug"--------------------------------------------"

    unless current_user.provider == "facebook" || current_user.provider == "twitter"
      unless @user.valid_password?(user_params[:current_password])
        return redirect_to edit_user_registration_url, notice: '現在のパスワードを正しく入力してください。'
      end


      if (user_params[:password].present? && user_params[:password_confirmation].blank?) ||
         (user_params[:password].blank? && user_params[:password_confirmation].present?) ||
         (user_params[:password].to_s != user_params[:password_confirmation].to_s) then
        return redirect_to edit_user_registration_url, notice: '変更後のパスワードを正しく入力してください。'
      end
      if (user_params[:password].to_s.length >= 1 && user_params[:password].to_s.length < 8)
        return redirect_to edit_user_registration_url, notice: 'パスワードは8文字以上で入力してください。'
      end
    end

    super
    #変更確認メール送信、image削除、パスワード更新、名前更新

    if user_params[:remove_image] == "1" then
      logger.debug"--------------------------------------------"
      logger.debug"remove_image"
      logger.debug"--------------------------------------------"
      user = User.find(current_user.id)
      user.update_attribute(:img_path_updated, '')
    end

     #if @user.update(user_params)
     if user_params[:image].present?
        #super
        logger.debug"--------------------------------------------"
        logger.debug"image_present"
        logger.debug(@user.image)
        logger.debug"--------------------------------------------"
        user = User.find(current_user.id)
        user.update_attribute(:img_path_updated, @user.image)
     end
   end


  private

#     def additional_task
#        if User.where(provider: "facebook").where(email: user_params[:email]).present?
#            return redirect_to new_user_session_url, notice: 'このメールアドレスはfacebook認証ですでに使われています！facebook認証でログインしてください！'
#         end
#     end

    def user_params
      params.require(:user).permit(:email, :password, :image, :remove_image, :name, :img_path, :img_path_updated, :current_password, :password_confirmation)
    end

#       def image_operation
#         logger.debug"--------------------------------------------"
#         logger.debug"after1"
#         logger.debug(user_params[:current_password])
#         logger.debug(@user.encrypted_password)
#         logger.debug"--------------------------------------------"

#          if user_params[:remove_image] == "1" then

#             user = User.find(current_user.id)
#             user.update_attribute(:img_path_updated, '')
#          end

#          if user_params[:image].present?
#           logger.debug"--------------------------------------------"
#           logger.debug"after2"
#           logger.debug(@user.image)
#           logger.debug"--------------------------------------------"
#            user = User.find(current_user.id)
#            user.update_attribute(:img_path_updated, @user.image)
#          end
#        end

    protected
    def update_resource(resource, params)
          logger.debug"--------------------------------------------"
          logger.debug"update_resource"
          logger.debug"--------------------------------------------"
       if current_user.provider == "facebook" || current_user.provider == "twitter"
         params.delete("current_password")
         resource.update_without_password(params)
       else
         resource.update_with_password(params)
          logger.debug"--------------------------------------------"
          logger.debug"update_with_password"
          logger.debug"--------------------------------------------"
       end
    end

#     def update_with_password(params, *options)
#       if params[:password].blank?
#         params.delete(:password)
#         params.delete(:password_confirmation) if params[:password_confirmation].blank?
#       end
#           logger.debug"--------------------------------------------"
#     logger.debug(params[:password])
#     logger.debug"--------------------------------------------"
#       update_attributes(params, *options)
#     end

#     def update_resorce(resorce,params)
#       if current_user.provider == "facebook" || current_user.provider == "twitter"
#         params.delete("current_password")
#         #resource.update_without_password(params)
#         resource.update_without_password(params.except(:current_password))
#       else
#          resorce.update_with_password(params)
#       end
#     end


#         def update_resource(resource, params)
#     logger.debug"--------------------------------------------"
#     logger.debug(@user.encrypted_password)
#     logger.debug"--------------------------------------------"
#           if @user.encrypted_password.blank?
#             resource.update_without_password(params.except(:current_password))
#            else
#             super
#            end
#    end

end
