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

post("/shoe_store/:id") do
  @shoe_brands = ShoeBrand.all()
  @shoe_store = ShoeStore.find(params["id"])
  title = params['shoe_brands']
  price = params['price']
  @shoe_brand = ShoeBrand.new({:title => title, :price => price})
  if shoe_brand.save()
    @shoe_store.shoe_brands.push(@shoe_brand)
    erb(:shoe_store)
  else
    redirect('/shoe_brand_error')
  end
end

post("/shoe_brand/:id") do
  @shoe_stores = ShoeStore.all()
  @shoe_brand = ShoeBrand.find(params["id"])
  title = params['shoe_stores']
  @shoe_store = ShoeStore.new({:title => title})
  if shoe_store.save()
    @shoe_brand.shoe_stores.push(@shoe_stores)
    erb(:shoe_brand)
  else
    redirect('/shoe_store_error')
  end
end


patch('/add_shoe_brand/:id') do
  @shoe_store = ShoeStore.find(params['id'])
  shoe_brand_ids = params.fetch('shoe_brand_ids')
  shoe_brand_ids.each do |i|
    shoe_brand = ShoeBrand.find(i)
    @shoe_store.shoe_brands.push(shoe_brand)
  end
  redirect("/shoe_store/#{@shoe_store.id}")
end

patch('/add_shoe_store/:id') do
  @shoe_brand = ShoeBrand.find(params['id'])
  shoe_store_ids = params.fetch('shoe_store_ids')
  shoe_store_ids.each do |i|
    shoe_store = ShoeStore.find(i)
    @shoe_brand.shoe_stores.push(shoe_store)
  end
  redirect("/shoe_brand/#{@shoe_brand.id}")
end
