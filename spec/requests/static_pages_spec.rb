require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Enoki Log' }
    let(:page_title) { '' }
    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }
  end

  # レイアウト上のリンクをテスト
  it "should have the right links on the layout" do
    visit root_path
    click_link "Enoki Log"
    expect(page).to have_title(full_title(''))
  end

end