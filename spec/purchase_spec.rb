require('spec_helper')

describe(Purchase) do
  describe('#product') do
    it "returns the products associated with the given purchase" do
      test_purchase = Purchase.create({:name => 'convinience'})
      test_product = Product.create({:name => 'napkins', :price => 2.50, :purchase_id => test_purchase.id()})
      test_product2 = Product.create({:name => 'solo cups', :price => 5, :purchase_id => test_purchase.id()})
      expect(test_purchase.product()).to(eq([test_product, test_product2]))
    end
  end
end
