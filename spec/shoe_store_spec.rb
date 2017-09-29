require('spec_helper')

describe(ShoeStore) do
  it { should have_many(:shoe_brands) }
  it("ensures the length of title is at most 40 characters") do
    shoe_store = ShoeStore.new({:title => "a".*(41)})
    expect(shoe_store.save()).to(eq(false))
  end
  it("ensures that title doesn't already exist") do
    ShoeStore.create({:title => 'Adidas Outlet'})
    shoe_store = ShoeStore.new({:title => 'adidas outlet'})
    expect(shoe_store.save()).to(eq(false))
  end
end
