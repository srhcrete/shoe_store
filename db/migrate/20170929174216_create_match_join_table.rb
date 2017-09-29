class CreateMatchJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:match_join) do |t|
    t.column(:shoe_store_id, :integer)
    t.column(:shoe_brand_id, :integer)
    t.timestamps()
  end
  remove_column(:shoe_stores, :shoe_brand_id, :integer)
  remove_column(:shoe_brands, :shoe_store_id, :integer)
  end
end
