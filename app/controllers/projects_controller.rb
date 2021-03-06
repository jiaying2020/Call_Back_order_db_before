class ProjectsController < ApplicationController
  include ProjectsHelper
  before_action :find_project,only: [:show, :edit, :update]


  def index
    @projects = Project.all
  end


  def user_projects_index
    @projects = Project.where(:user_id => current_user.id)
  end

  def show
    @givebacks = @project.givebacks
  end

  def new
    @project = Project.new
    2.times{ @project.givebacks.build }
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to user_projects_path(current_user), notice: '成功新增專案'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path, notice: '提案內容已更新'
    else
      render :edit
    end
  end

  private
  # def user_projects
  #   @user_projects = Project.find_by(user_id: 1)
  # end

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :category, :summary, :content, :pic, :target_amount, :user_id, givebacks_attributes: [:id, :title, :price, :deliver_time, :_destroy])
  end
end
