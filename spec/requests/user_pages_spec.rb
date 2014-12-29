require 'spec_helper'

describe "User pages" do

	subject { page }

  # Sign-Up
	describe "signup page" do
		before { visit signup_path }
		it { should have_content('Sign up') }
		it { should have_title(full_title('Sign up')) }
	end

	describe "signup" do
		before { visit signup_path }
		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Email",				with: "user@example.com"
				fill_in "Password",		 with: "foobar"
				fill_in "Confirm Password", with: "foobar"
			end
			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        it { should have_title('MyPage') }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title('MyPage') }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
		end

		describe "after submission" do
        before { click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('error') }
      end
	end

  # Show
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:subject, user: user, title: "Foo", description: "Lorem ipsum 1", url: "123456789abc", start_day: Date.new(2014, 8, 30), end_day: Date.new(2014, 9, 21)) }
    let!(:m2) { FactoryGirl.create(:subject, user: user, title: "Bar", description: "Lorem ipsum 2", url: "123456789def", start_day: Date.new(2014, 9, 30), end_day: Date.new(2014, 10, 21)) }

    before do
      sign_in user
      visit user_path(user)
    end

    it { should have_content(user.email) }
    it { should have_title('MyPage') }

    describe "subject" do
      it { should have_content(m1.title) }
      it { should have_content(m2.title) }
      it { should have_content(user.subjects.count) }
    end
  end

  # Edit
	describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
		  sign_in user
		  visit edit_user_path(user)
		end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title('MyPage') }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
