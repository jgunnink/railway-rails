class ProjectsController < AuthenticatedController
  before_action :find_client

  def index
    authorize!(:index, Project)
    @projects = Project.where(client: params[:client_id])
    @ransack_query = @projects.ransack(params[:q])
    @projects = @ransack_query.result.page(params[:page])
  end

  def new
    @project = Project.new
    authorize!(:new, @project)
  end

  def create
    @project = Project.new(strong_params_for_project)
    authorize!(:create, @project)
    @project.save

    respond_with(@project, location: client_projects_path(@client))
  end

  def edit
    @project = find_project
    authorize!(:edit, @project)
  end

  def show
    @project = find_project
    authorize!(:edit, @project)
  end

  def update
    @project = find_project
    @project.assign_attributes(strong_params_for_project)
    authorize!(:update, @project)
    @project.save

    respond_with(@project, location: client_projects_path(@client))
  end

  def destroy
    @project = find_project
    authorize!(:destroy, @project)
    @project.destroy

    respond_with(@project, location: client_projects_path(@client))
  end

private

  def strong_params_for_project
    params.fetch(:project, {}).permit([:client_id, :name])
  end

  def find_project
    Project.find(params[:id])
  end

  def find_client
    @client = Client.find(params[:client_id])
  end

end
