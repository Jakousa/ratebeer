require 'rails_helper'

include Helpers

describe "User" do
  let!(:user) { FactoryBot.create :user }

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  describe "who has signed up" do

    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end

    describe "and has ratings" do
      let(:beer) { FactoryBot.create :beer }
  
      before :each do
        FactoryBot.create(:rating, beer: beer, score: 3, user: user)
        visit user_path(user)
      end
      
      it "can see their favorite style" do
        expect(page).to have_content "Favorite style is: #{beer.style}"
      end
  
      it "can see their favorite brewery" do
        expect(page).to have_content "Favorite brewery is: #{beer.brewery.name}"
      end
    end
  end
end