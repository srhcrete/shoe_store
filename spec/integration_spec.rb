require('capybara/rspec')
require('spec_helper')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the app', {:type => :feature}) do
  describe('index page') do
    it('shows all shoe_stores') do
      store = ShoeStore.new(:title => 'Tom\'s Cobblers')
      store.save()
      visit('/')
      expect(page).to have_content('Tom\'s Cobblers')
    end
  end

  describe('adding a new store', {:type => :feature}) do
    it('allows a user to add a store') do
      visit('/')
      click_link('Add or Delete a store!')
      fill_in('title', :with => 'Adidas Outlet')
      click_button('Add Shoe Store')
      expect(page).to have_content('Adidas Outlet')
    end
  end

  describe('deleting a store', {:type => :feature}) do
    it('allows a user to delete a store') do
      ShoeStore.create(:title => 'Tom\'s Cobblers')
      visit('/')
      click_link('Add or Delete a store!')
      check('Tom\'s Cobblers')
      click_button('Delete Selected Shoe Stores')
      expect(page).not_to have_content('Tom\'s Cobblers')
    end
  end
end
