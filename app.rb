require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')


get('/') do
  @shoe_stores = ShoeStore.all()
  @shoe_brands = ShoeBrand.all()
  erb(:index)
end

get('/add_shoe_store') do
  @shoe_stores = ShoeStore.all()
  erb(:add_shoe_store)
end

get('/add_shoe_brand') do
  @shoe_brands = ShoeBrand.all()
  erb(:add_shoe_brand)
end

get("/shoe_store/:id") do
  @shoe_store = ShoeStore.find(params["id"])
  @shoe_brands = ShoeBrand.all()
  erb(:shoe_store)
end

get("/shoe_brand/:id") do
  @shoe_brand = ShoeBrand.find(params["id"])
  @shoe_stores = ShoeStore.all()
  erb(:shoe_brand)
end

post('/create_shoe_store') do
  title = params['title']
  @shoe_store = ShoeStore.new({:title => title})
  if @shoe_store.save()
    redirect('/add_shoe_store')
  else
    erb(:shoe_store_error)
  end
end

post('/create_shoe_brand') do
  title = params['title']
  price = params['price']
  @shoe_brand = ShoeBrand.new({:title => title, :price => price})
  if @shoe_brand.save()
    redirect('/add_shoe_brand')
  else
    erb(:shoe_brand_error)
  end
end
