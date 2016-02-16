class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.find(params[:id])
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    @user_id = current_user.id
    @blog.user_id = @user_id
    logger.debug"--------------------------------------------"
    logger.debug(@blog.user_id)
    logger.debug"--------------------------------------------"
  end

  # GET /blogs/1/edit
  def edit
    unless @blog.user.id == current_user.id
      respond_to do |format|
        format.html { redirect_to blogs_path, notice: '不正な操作が実行されました' }
        format.json { render :show, status: :created, location: @blog }
      end
    end
  end

  # POST /blogs
  # POST /blogs.json
  def create
#     unless blog_params[:user_id] == current_user.id
#       respond_to do |format|
#         format.html { redirect_to blogs_path, notice: '不正な操作が実行されました' }
#         format.json { render :show, status: :created, location: @blog }
#       end
#     else
      @blog = Blog.new(blog_params)
      respond_to do |format|
        if @blog.save
          format.html { redirect_to @blog, notice: 'ブログが正しく更新されました' }
          format.json { render :show, status: :created, location: @blog }
        else
          format.html { render :new }
          format.json { render json: @blog.errors, status: :unprocessable_entity }
        end
      end
    #end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
#     logger.debug"--------------------------------------------"
#     logger.debug(blog_params[:user_id])
#     logger.debug(current_user.id)
#     logger.debug"--------------------------------------------"
#     unless blog_params[:user_id] == current_user.id
#       respond_to do |format|
#         format.html { redirect_to blogs_path, notice: '不正な操作が実行されました' }
#         format.json { render :show, status: :created, location: @blog }
#       end
#     else
      respond_to do |format|
        if @blog.update(blog_params)
          format.html { redirect_to @blog, notice: 'ブログが正しく更新されました' }
          format.json { render :show, status: :ok, location: @blog }
        else
          format.html { render :edit }
          format.json { render json: @blog.errors, status: :unprocessable_entity }
        end
      end
    #end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    unless @blog.user.id == current_user.id
      respond_to do |format|
        format.html { redirect_to blogs_path, notice: '不正な操作が実行されました' }
        format.json { render :show, status: :created, location: @blog }
      end
    else
      @blog.destroy
      respond_to do |format|
        format.html { redirect_to blogs_url, notice: 'ブログが正しく削除されました' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      unless Blog.exists?(id: params[:id])
        respond_to do |format|
          format.html { redirect_to blogs_path, notice: '不正な操作が実行されました' }
          format.json { render :show, status: :created, location: @blog }
        end
      else
        @blog = Blog.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :content, :user_id)
    end
end
