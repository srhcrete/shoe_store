require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new store', {:type => :feature}) do
  it('allows a user to add a store') do
    visit('/')
    click_link('Add a store to the list!')
    fill_in('title', :with => 'Adidas Outlet')
    click_button('Add Shoe Store')
    expect(page).to have_content('Adidas Outlet')
  end
end
