require 'rails_helper'
require 'cancan/matchers'

describe AdminAbility do

  subject { ability }

  let(:ability) { AdminAbility.new(user) }
  let(:user) { FactoryGirl.create(:user, :admin) }

  it { should be_able_to(:manage, :all) }

  describe "managing Users" do
    it { should be_able_to(:show, :admin_dashboard) }
    it { should_not be_able_to(:show, :user_dashboard) }
  end

  describe "managing Clients" do
    it { should be_able_to(:create, FactoryGirl.create(:client)) }
    it { should be_able_to(:update, FactoryGirl.create(:client)) }
    it { should be_able_to(:destroy, FactoryGirl.create(:client)) }
  end

end
