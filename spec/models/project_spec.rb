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

  describe "@stage" do
    it { should validate_presence_of(:stage) }
    it { should validate_numericality_of(:stage).only_integer
                                                .is_greater_than(0)
                                                .is_less_than(6)
       }
  end

  describe "#to_s" do
    subject { Project.new(name: "Name").to_s }
    it { should eq("Name") }
  end

end
