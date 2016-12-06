class ClientsController < AuthenticatedController

  def index
    authorize!(:index, Client)
    @ransack_query = Client.ransack(params[:q])
    @ransack_query.sorts = 'name ASC' if @ransack_query.sorts.empty?
    @clients = Client.all.merge(@ransack_query.result)
                         .page(params[:page])
  end

  def new
    @client = Client.new
    authorize!(:new, @client)
  end

  def create
    @client = Client.new(strong_params_for_client)
    authorize!(:create, @client)
    @client.save

    respond_with(@client, location: clients_path)
  end

  def edit
    @client = find_client
    authorize!(:edit, @client)
  end

  def show
    @client = find_client
    authorize!(:show, @client)
  end

  def update
    @client = find_client
    @client.assign_attributes(strong_params_for_client)
    authorize!(:update, @client)
    @client.save

    respond_with(@client, location: clients_path)
  end

  def destroy
    @client = find_client
    authorize!(:destroy, @client)
    @client.destroy

    respond_with(@client, location: clients_path)
  end

private

  def strong_params_for_client
    params.fetch(:client, {}).permit([
      :contact_name,
      :contact_phone,
      :email,
      :name
    ])
  end

  def find_client
    Client.find(params[:id])
  end

end
