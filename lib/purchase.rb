class Purchase < ActiveRecord::Base
  has_many(:product)
  after_destroy(:reset_product_associates)

private
  define_method(:reset_product_associates) do
    products = self.product()
    products.each() do |product|
      product.update({:purchase_id => nil})
    end
  end

end
