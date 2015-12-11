require 'spec_helper'

feature "user creates a new meetup" do
  let!(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "cannot create meetup if not signed in" do
    visit '/'
    click_link('Create a New Meetup')

    expect(page).to have_content "Please sign in"
  end

  scenario "can create a new meetup if signed in" do
    visit '/'
    sign_in_as user
    click_link('Create a New Meetup')

    expect(page).to have_content "Create a new meetup"
  end

  scenario "will display an error if not all information is filled out" do
    visit '/'
    sign_in_as user
    click_link('Create a New Meetup')
    fill_in "Choose a Meetup Name", with: "Cheese Club"
    click_button("submit")
    expect(page).to have_content "Location can't be blank"
    expect(find_field('name').value).to have_content("Cheese Club")
  end

  scenario "will bring user to new meetup if successfully created" do
    visit '/'
    sign_in_as user
    click_link('Create a New Meetup')
    fill_in "Choose a Meetup Name", with: "Cheese Club"
    fill_in "Choose a Meetup Location", with: "1 Cow Place"
    fill_in "Describe your Meetup", with: "We eat cheeese and Adam cries"
    click_button("submit")
    expect(page).to have_content "Cheese Club"
    expect(page).to have_content "jarlax1"
    expect(page).to have_content "New Meetup Created!"
  end
end
