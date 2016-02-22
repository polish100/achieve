class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
  end

  def update

      #@user.update(user_params)

      respond_to do |format|
        if @user.update(user_params)
           @user.update( img_path: @user.image )
           format.html { redirect_to @user, notice: '画像がアップロードされました' }
           format.json { render :show, status: :ok, location: @user }
        else
           format.html { render :edit }
           format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end
#    def destroy
#      @user.destroy
#    end
end

 private
  def set_user
      @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile, :image, :image_cache, :img_path)
  end
