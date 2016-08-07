class CommentsController < ApplicationController

  def index
    @comment = Comment.all
  end

  def show
  end

  def edit
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_path(@comment.blog), notice: 'コメントは削除されました。' }
      format.json { head :no_content }
      format.js { render :index, notice: 'コメントは削除されました。' }
    end
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog

    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.json { render :show, status: :created, location: @comment }
        format.js { render :index }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:blog_id, :content)
  end
end
