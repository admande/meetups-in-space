require 'spec_helper'

feature "User sees meetups" do
  let!(:jarlax) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end


  let!(:membership) do
    Membership.create(
    user_id: 1,
    meetup_id: 1
    )
  end

  let!(:meetup) do
      Meetup.create(
      name: "Hacker Monkeys",
      details: "This is where we code stuff",
      location: "344 Loring Street, Boston, MA",
      creator: jarlax
    )
  end

  scenario "successful sign in" do
    visit '/'
    click_link("Hacker Monkeys")
    expect(page).to have_content "Hacker Monkeys"
    expect(page).to have_content "This is where we code stuff"
    expect(page).to have_content "344 Loring Street, Boston, MA"
    expect(page).to have_content "jarlax1"
  end
end
