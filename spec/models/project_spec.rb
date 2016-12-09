require 'rails_helper'

describe Project do

  describe "@name" do
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_presence_of(:name) }
    describe "validating uniqueness" do
      subject { FactoryGirl.create(:project) }
      it { should validate_uniqueness_of(:name).scoped_to(:client_id) }
    end
  end

  describe "@client" do
    it { should validate_presence_of(:client) }
  end

  describe "#to_s" do
    subject { Project.new(name: "Name").to_s }
    it { should eq("Name") }
  end

end
