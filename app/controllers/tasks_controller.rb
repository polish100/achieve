class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  # before_action :set_task, only: [:show, :edit, :update, :destroy, before_action :authenticate_user!]
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.where(user_id: params[:user_id]).where.not(done: true)
                 .order(updated_at: :desc)
    @user = User.find(params[:user_id])
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new(user_id: params[:user_id], charge_id: params[:user_id])
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to user_tasks_url, notice: 'タスクを登録しました。' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to user_tasks_url, notice: 'タスクを登録しました。' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to user_tasks_url, notice: 'タスクを削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:user_id, :title, :content, :deadline, :charge_id, :done, :status)
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(user_tasks_path(current_user)) unless current_user == @user
    end
end
