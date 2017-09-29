require('spec_helper')

describe(ShoeBrand) do
  it { should have_many(:shoe_stores) }
  it("ensures the length of title is at most 40 characters") do
    shoe_brand = ShoeBrand.new({:title => "a".*(41)})
    expect(shoe_brand.save()).to(eq(false))
  end
  it("ensures that title doesn't already exist") do
    ShoeBrand.create({:title => 'Adidas'})
    shoe_brand = ShoeBrand.new({:title => 'adidas'})
    expect(shoe_brand.save()).to(eq(false))
  end
end
