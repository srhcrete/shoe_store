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

describe('searching for a store', {:type => :feature}) do
  it('allows a user to search for a store') do
    ShoeStore.create(:title => 'Tom\'s Cobblers')
    visit('/')
    fill_in('search_store', :with => 'Tom\'s Cobblers')
    click_button('Search Stores')
    expect(page).to have_content('Tom\'s Cobblers')
  end
end

  describe('adding a new brand', {:type => :feature}) do
    it('allows a user to add a brand') do
      visit('/')
      click_link('Add or Delete a brand!')
      fill_in('title', :with => 'Superstars')
      fill_in('price', :with => '80.00')
      click_button('Add Shoe brand')
      expect(page).to have_content('Superstars')
    end
  end
end

describe('deleting a brand', {:type => :feature}) do
  it('allows a user to delete a brand') do
    ShoeBrand.create(:title => 'Superstars', :price => '80.00')
    visit('/')
    click_link('Add or Delete a brand!')
    check('Superstars')
    click_button('Delete Selected Shoe brands')
    expect(page).not_to have_content('Superstars')
  end
end

describe('updating a store name', {:type => :feature}) do
  it('allows a user to update a store name') do
    ShoeStore.create(:title => 'Tom\'s Cobblers')
    visit('/')
    click_link('Tom\'s Cobblers')
    fill_in('store_name', :with => 'Shoe Palace')
    click_button('Update Store Name')
    expect(page).to have_content('Shoe Palace')
  end
end
