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
    erb(:add_store_fail)
  end
end

post('/create_shoe_brand') do
  title = params['title']
  price = params['price']
  @shoe_brand = ShoeBrand.new({:title => title, :price => price})
  if @shoe_brand.save()
    redirect('/add_shoe_brand')
  else
    erb(:add_brand_fail)
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
    redirect('/add_brand_fail')
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
    redirect('/add_store_fail')
  end
end

patch('/add_shoe_brand/:id') do
  @shoe_store = ShoeStore.find(params['id'])
  if params.has_key?('shoe_brand_ids') == false
    erb(:add_brand_fail)
  else
    params.fetch('shoe_brand_ids').each do |i|
      shoe_brand = ShoeBrand.find(i)
      @shoe_store.shoe_brands.push(shoe_brand)
      redirect("/shoe_store/#{@shoe_store.id}")
    end
  end
end

patch('/add_shoe_store/:id') do
  @shoe_brand = ShoeBrand.find(params['id'])
  if params.has_key?('shoe_store_ids') == false
    erb(:add_store_fail)
  else
    params.fetch('shoe_store_ids').each do |i|
    shoe_store = ShoeStore.find(i)
    @shoe_brand.shoe_stores.push(shoe_store)
    redirect("/shoe_brand/#{@shoe_brand.id}")
    end
  end
end

delete('/delete_shoe_store') do
  shoe_store_ids = params.fetch('shoe_store_ids')
  shoe_store_ids.each do |i|
  ShoeStore.find(i).delete()
  end
  redirect('/add_shoe_store')
end

delete('/delete_shoe_brand') do
  shoe_brand_ids = params.fetch('shoe_brand_ids')
  shoe_brand_ids.each do |i|
  ShoeBrand.find(i).delete()
  end
  redirect('/add_shoe_brand')
end

post("/search_shoe_store") do
  search_query = params['search']
  @shoe_store = ShoeStore.where("title ILIKE (?)", "%#{search_query}%").first
  if @shoe_store
    id = @shoe_store.id
    redirect("/shoe_store/#{id}")
  else
    erb(:store_search_fail)
  end
end
