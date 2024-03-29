require "rails_helper"

RSpec.describe Admin::MembersController do

  describe "GET index" do
    subject(:get_index) { get :index, params }
    let(:params) { {} }

    authenticated_as(:admin) do
      it { should be_success }

      describe_assign(:users) do
        subject(:users) { get_index; assigns(:users) }

        describe "filtering by role" do
          it { should include(FactoryGirl.create(:user, :member)) }
          it { should_not include(FactoryGirl.create(:user, :admin)) }
        end
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe "GET new" do
    subject { get :new }

    authenticated_as(:admin) do
      it { should be_success }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe "POST create" do
    subject(:create_user) { post :create, user: params }
    let(:params) { {} }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:params) do
          {
            given_names: "JK",
            family_name: "Gunnink",
            email: "email@example.com",
            password: "password"
          }
        end

        it "creates a User object with the given attributes" do
          create_user

          user = User.member.find_by({
            email: params[:email],
            given_names: params[:given_names],
            family_name: params[:family_name]
          })
          expect(user).to be_present
        end

        it { should redirect_to(admin_members_path) }
      end

      context "with invalid parameters" do
        let(:params) { {email: nil} }
        specify { expect { subject }.not_to change(User, :count) }
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe "GET edit" do
    subject { get :edit, id: target_user.id }
    let(:target_user) { FactoryGirl.create(:user, :member) }

    authenticated_as(:admin) do
      it { should be_success }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe "POST update" do
    subject(:update_user) { post :update, id: target_user.id, user: params }
    let(:params) { {} }
    let(:target_user) { FactoryGirl.create(:user, :member, email: "pending@example.com") }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:params) do
          {
            given_names: "JK",
            family_name: "Gunnink",
            email: "jk@example.com",
            password: ""
          }
        end

        it "updates a User object with the given attributes" do
          update_user

          target_user.reload
          # When we update the user, the new email is not changed until confirmed.
          expect(target_user.email).to eq("pending@example.com")
          expect(target_user.given_names).to eq("JK")
          expect(target_user.family_name).to eq("Gunnink")
          expect(target_user).to be_member
        end

        it { should redirect_to(admin_members_path) }
      end

      context "with invalid parameters" do
        let(:params) do
          {
            email: "not_an_email"
          }
        end

        it "doesn't update the User" do
          update_user
          expect(target_user.reload.email).not_to eq(params[:email])
        end
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe "DELETE destroy" do
    subject { delete :destroy, id: target_user.id }
    let(:target_user) { FactoryGirl.create(:user, :member) }

    authenticated_as(:admin) do
      it "deletes the user" do
        subject
        expect(target_user.reload.deleted_at).to be_present
      end
      it { should redirect_to(admin_members_path) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

end
