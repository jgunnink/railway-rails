require 'rails_helper'

describe ClientsController do

  describe 'GET index' do
    subject { get :index }

    authenticated_as(:admin) do
      it { should render_template(:index) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin, :member]
  end

  describe 'GET new' do
    subject { get :new }

    authenticated_as(:admin) do
      it { should render_template(:new) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin, :member]
  end

  describe 'POST create' do
    subject { post :create, client: attributes }
    let(:attributes) { {} }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:client_attributes) { FactoryGirl.attributes_for(:client) }
        let(:attributes) do
          {
            name: client_attributes[:name],
            email: client_attributes[:email],
            contact_name: client_attributes[:contact_name],
            contact_phone: client_attributes[:contact_phone]
          }
        end

        it "creates a Client object with the given attributes" do
          subject

          client = Client.order(:created_at).last
          expect(client).to be_present
          expect(client.name).to eq(client_attributes[:name])
          expect(client.email).to eq(client_attributes[:email])
          expect(client.contact_name).to eq(client_attributes[:contact_name])
          expect(client.contact_phone).to eq(client_attributes[:contact_phone])
        end

        it { should redirect_to(clients_path) }

        it "sets a notice for the user" do
          subject
          expect(flash[:notice]).to be_present
        end
      end

      context "with invalid parameters" do
        let(:attributes) { parameters_for(:client, :invalid) }
        specify { expect { subject }.not_to change { Client.count } }
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin, :member]
  end

  describe 'GET edit' do
    subject { get :edit, id: client.id }
    let!(:client) { FactoryGirl.create(:client) }

    authenticated_as(:admin) do
      it { should render_template(:edit) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin, :member]
  end

  describe 'POST update' do
    subject { post :update, id: client.id, client: attributes }
    let!(:client) { FactoryGirl.create(:client) }

    let(:attributes) { {} }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:client_attributes) { FactoryGirl.attributes_for(:client) }
        let(:attributes) do
          {
            name: client_attributes[:name],
            email: client_attributes[:email],
            contact_name: client_attributes[:contact_name],
            contact_phone: client_attributes[:contact_phone]
          }
        end

        it "updates the Client object with the given attributes" do
          subject

          client.reload
          expect(client.name).to eq(client_attributes[:name])
          expect(client.email).to eq(client_attributes[:email])
          expect(client.contact_name).to eq(client_attributes[:contact_name])
          expect(client.contact_phone).to eq(client_attributes[:contact_phone])
        end

        it { should redirect_to(clients_path) }

        it "sets a notice for the user" do
          subject
          expect(flash[:notice]).to be_present
        end
      end

      context "with invalid parameters" do
        let(:attributes) { parameters_for(:client, :invalid) }

        it "doesn't update the Client" do
          subject
          expect(client.reload).not_to have_attributes(attributes)
        end
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin, :member]
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, id: client.id }
    let!(:client) { FactoryGirl.create(:client) }

    authenticated_as(:admin) do
      it "deletes the Client" do
        subject
        expect(client.reload.deleted_at).to be_present
      end
      it { should redirect_to(clients_path) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

end
