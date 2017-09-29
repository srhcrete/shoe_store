require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')


get('/') do
  @shoe_store = ShoeStore.all()
  erb(:index)
end
