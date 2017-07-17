require "rails_helper"

RSpec.describe "viewing user's links" do
  it "should load all user's links" do
    user = create(:user_with_links)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(user.links.count).to eq(3)
  end
end
