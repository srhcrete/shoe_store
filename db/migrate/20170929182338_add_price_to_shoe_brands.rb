class AddPriceToShoeBrands < ActiveRecord::Migration[5.1]
  def change
    add_column(:shoe_brands, :price, :decimal, :precision =>8, :scale =>2)
  end
end

# <span><%= number_to_currency(product.price) %</span>
