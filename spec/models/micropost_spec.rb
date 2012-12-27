# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "micropost associations" do

    let(:user1) { FactoryGirl.create(:user) }
    #before { user1.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: user1, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: user1, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      user1.microposts.should == [newer_micropost, older_micropost]
    end

    it "should destroy associated microposts" do
      microposts = user1.microposts.dup
      user1.destroy
      microposts.should_not be_empty
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil #these are equivalent
        lambda { Micropost.find(micropost.id) }.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end
  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end
  describe "with content that is too long" do
    before { @micropost.content = "a"*141 }
    it { should_not be_valid }
  end
end
