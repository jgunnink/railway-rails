require 'rails_helper'

describe Client do

  describe "@contact_name" do
    it { should validate_length_of(:contact_name).is_at_least(2).is_at_most(30) }
    it { should validate_presence_of(:contact_name) }
  end

  describe "@contact_phone" do
    it { should validate_length_of(:contact_phone).is_at_least(8).is_at_most(20) }
  end

  describe "@email" do
    it { should validate_length_of(:email).is_at_least(6) }
    it { should validate_presence_of(:email) }
    describe "validating uniqueness" do
      subject { FactoryGirl.create(:client) }
      it { should validate_uniqueness_of(:email) }
    end
  end

  describe "@name" do
    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_presence_of(:name) }
    describe "validating uniqueness" do
      subject { FactoryGirl.create(:client) }
      it { should validate_uniqueness_of(:name) }
    end
  end

  describe "#to_s" do
    subject { Client.new(name: "Name").to_s }
    it { should eq("Name") }
  end

end
