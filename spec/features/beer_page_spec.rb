require 'rails_helper'

describe "Beer" do
    before :each do
        FactoryBot.create(:brewery)
        visit new_beer_path
    end
    
    it "can be created with valid name" do
        fill_in('beer_name', with: 'Test_Beer1')
        expect{
            click_button('Create Beer')
          }.to change{ Beer.count }.by(1)
    end

    it "can not be created with invalid name" do
        expect{
            click_button('Create Beer')
          }.to change{ Beer.count }.by(0)
        expect(page).to have_content 'Name is too short (minimum is 1 character)'
    end
end