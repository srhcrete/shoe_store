class Match < ActiveRecord::Base
  belongs_to :shoe_store
  belongs_to :shoe_brand
end
