require 'spec_helper'

describe Subject do
	let(:user) { FactoryGirl.create(:user) }
  before { @subject = user.subjects.build(title: "foobar", description: "Lorem ipsum", url: "123456789abc", start_day: Date.new(2014, 8, 30), end_day: Date.new(2014, 9, 21)) }

  subject { @subject }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:url) }
  it { should respond_to(:start_day) }
  it { should respond_to(:end_day) }

  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @subject.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @subject.title = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @subject.title = "a" * 71 }
    it { should_not be_valid }
  end
end
