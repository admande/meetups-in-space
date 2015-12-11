require 'spec_helper'
require 'pry'

feature "User sees meetups" do
  let!(:user) do
    User.create(
      id: 3,
      provider: "github",
      uid: "3",
      username: "adam",
      email: "adam@launchacademy.com"
    )
  end

  let!(:jarlax) do
    User.create(
      id: 1,
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  let!(:richardlax) do
    User.create(
      id: 2,
      provider: "github",
      uid: "2",
      username: "richlax",
      email: "richlax@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end


  let!(:membership) do
    Membership.create(
    user_id: 1,
    meetup_id: 6
    )
  end

  let!(:membership2) do
    Membership.create(
    user_id: 2,
    meetup_id: 6
    )
  end

  let!(:meetup) do
      Meetup.create(
      id: 6,
      name: "Hacker Monkeys",
      details: "This is where we code stuff",
      location: "344 Loring Street, Boston, MA",
      creator: jarlax
    )
  end

  scenario "user is not signed in and sees a button to join a meetup" do
    visit '/meetups/6'
    expect(page).to have_css("input")


    click_button("submit")
    expect(page).to have_content("Please sign in")
  end

  scenario "user is signed in and joins a group" do
    visit '/'
    sign_in_as user
    click_link("Hacker Monkeys")
    save_and_open_page
    click_button("submit")

    expect(page).to_not have_css("input")
  end

  scenario "user is signed in is already a member of a group" do
  end



end
