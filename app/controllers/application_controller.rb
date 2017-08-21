class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :danger, :info, :warning

  before_action :authenticate_user!, :status_task
  before_filter :sidebar

  def sidebar
    @projects = Project.where(user_id: current_user).all
    @tasks_today = Task.where(project: @projects).where("(deadline LIKE :today or deadline < :nowtime or deadline is NULL) and status = :status", :today => "#{Date.today}%", :nowtime => DateTime.now, :status => false)
  	@quantity_today = @tasks_today.size
  end

  private
    def status_task
    	Task.where("deadline < :nowtime and status = :status", :nowtime => DateTime.now, :status => false).update_all(:priority => 1)
    end

end
