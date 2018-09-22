require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "view has list of all ratings and their count" do
    FactoryBot.create(:rating, beer: beer1, score: 1, user: user)
    FactoryBot.create(:rating, beer: beer2, score: 2, user: user)
    visit ratings_path
    expect(page).to have_content beer1.name
    expect(page).to have_content beer2.name
    expect(page).to have_content 'Number of ratings: 2'
  end

  it "by user are displayed on users page" do
    user2 = FactoryBot.create(:user, username: 'One')
    FactoryBot.create(:rating, beer: beer1, score: 1, user: user2)
    FactoryBot.create(:rating, beer: beer2, score: 2, user: user2)
    FactoryBot.create(:rating, beer: beer2, score: 3, user: user)
    visit user_path(user)
    expect(page).to have_content beer2.name
    expect(page).not_to have_content beer1.name
  end

  it "can be deleted by user" do
    FactoryBot.create(:rating, beer: beer2, score: 3, user: user)
    visit user_path(user)
    expect{
        click_link('delete')
      }.to change{Rating.count}.by(-1)
  end
end