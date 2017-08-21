class TasksController < ApplicationController
  before_action :set_task, only: [:done_return, :done, :show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:create, :update]

  # GET /tasks
  # GET /tasks.json
  def index
    redirect_to today_tasks_path
  end

  # GET /tasks/today
  def today
    @tasks = @tasks_today.all
  end

  # GET /tasks/next_seven_days
  def next_seven_days
    @tasks = Task.where(project: @projects).where("(deadline <= :today or deadline is NULL) and status = :status", :today => Date.today+7, :nowtime => DateTime.now, :status => false).all
  end

  # GET /tasks/archive
  def archive
    @tasks = Task.where(status: true, project: @projects).all
  end

  # GET /tasks/done/1
  def done
    Task.update(@task, {status: true})

    respond_to do |format|
      format.html { redirect_to today_tasks_path, notice: t('common.tasks.done.text_true') }
    end
  end

  # GET /tasks/done_return/1
  def done_return
    Task.update(@task, {status: false})

    respond_to do |format|
      format.html { redirect_to today_tasks_path, notice: t('common.tasks.done.text_false') }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.json { render :show, status: :created, location: @task }
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.json { render :show, status: :ok, location: @task }
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: t('common.tasks.destroy.text_true') }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.where(id: params[:id], project: @projects).take
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :priority, :project_id, :deadline)
    end
end
