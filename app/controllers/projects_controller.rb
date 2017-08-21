class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:create, :update]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where(user_id: current_user).all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @tasks = Task.where(status: false, project: @project).all
  end

  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.json { render :show, status: :created, location: @project }
      else
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.json { render :show, status: :ok, location: @project }
      else
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  def destroy
    tasks = Task.where(project: @project, status: false)
    if !tasks.any? then
      Task.destroy_all(project: @project)
      @project.destroy

      notice = t('common.projects.destroy.text_true')
    else
      notice = t('common.projects.destroy.text_false')
    end

    respond_to do |format|
      format.html { redirect_to projects_url, notice: notice }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.where(id: params[:id], user_id: current_user).take
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :flag, :user_id)
    end
end
