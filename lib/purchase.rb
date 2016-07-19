class Purchase < ActiveRecord::Base
  has_many(:product)
end
