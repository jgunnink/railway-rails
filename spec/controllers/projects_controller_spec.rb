require 'rails_helper'

describe ProjectsController do

  describe 'GET index' do
    subject { get :index }

    authenticated_as(:admin) do
      it { should render_template(:index) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'GET new' do
    subject { get :new }

    authenticated_as(:admin) do
      it { should render_template(:new) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'POST create' do
    subject { post :create, project: attributes }
    let(:attributes) { {} }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:project_attributes) { FactoryGirl.attributes_for(:project) }
        let!(:client) { FactoryGirl.create(:client) }
        let(:attributes) do
          {
            name: project_attributes[:name],
            client_id: client.id
          }
        end

        it "creates a Project object with the given attributes" do
          subject

          project = Project.order(:created_at).last
          expect(project).to be_present
          expect(project.name).to eq(project_attributes[:name])
          expect(project.client).to eq(client)
        end

        it { should redirect_to(client_projects_path(client_id)) }

        it "sets a notice for the user" do
          subject
          expect(flash[:notice]).to be_present
        end
      end

      context "with invalid parameters" do
        let(:attributes) { parameters_for(:project, :invalid) }
        specify { expect { subject }.not_to change { Project.count } }
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'GET edit' do
    subject { get :edit, id: project.id }
    let!(:project) { FactoryGirl.create(:project) }

    authenticated_as(:admin) do
      it { should render_template(:edit) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'POST update' do
    subject { post :update, id: project.id, project: attributes }
    let!(:project) { FactoryGirl.create(:project) }

    let(:attributes) { {} }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:project_attributes) { FactoryGirl.attributes_for(:project) }
        let!(:client) { FactoryGirl.create(:client) }
        let(:attributes) do
          {
            name: project_attributes[:name],
            client_id: client.id
          }
        end

        it "updates the Project object with the given attributes" do
          subject

          project.reload
          expect(project.name).to eq(project_attributes[:name])
          expect(project.client).to eq(client)
        end

        it { should redirect_to(client_projects_path(client_id)) }

        it "sets a notice for the user" do
          subject
          expect(flash[:notice]).to be_present
        end
      end

      context "with invalid parameters" do
        let(:attributes) { parameters_for(:project, :invalid) }

        it "doesn't update the Project" do
          subject
          expect(project.reload).not_to have_attributes(attributes)
        end
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, id: project.id }
    let!(:project) { FactoryGirl.create(:project) }

    authenticated_as(:admin) do
      it "deletes the Project" do
        subject
        expect(project.reload.deleted_at).to be_present
      end
      it { should redirect_to(client_projects_path(client_id)) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

end
