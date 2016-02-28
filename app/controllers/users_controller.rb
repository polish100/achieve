class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy, :image]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    unless @user.id == current_user.id
      respond_to do |format|
        format.html { redirect_to users_path, notice: '不正な操作が実行されました' }
        format.json { render :show, status: :created, location: @user }
      end
    end
  end

  def update

      #@user.update(user_params)

      respond_to do |format|
        if @user.update(user_params)
           @user.update( img_path: @user.image )
           format.html { redirect_to @user, notice: '画像が更新されました' }
           format.json { render :show, status: :ok, location: @user }
        else
           format.html { render :edit }
           format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end

  def image
    logger.debug"--------------------------------------------"
    logger.debug(@user.image)
    logger.debug(send_data(@user.image, disposition: :inline))
    logger.debug"--------------------------------------------"
    send_data(@user.image, disposition: :inline)

  end
end



 private
  def set_user
    unless User.exists?(id: params[:id])
      respond_to do |format|
        format.html { redirect_to users_path, notice: '不正な操作が実行されました' }
        format.json { render :show, status: :created, location: @user }
      end
    else
      @user = User.find(params[:id])
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile, :image, :image_cache, :img_path)
  end
