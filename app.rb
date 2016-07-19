require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('sinatra/activerecord')
require('./lib/purchase')
require('./lib/product')
require('pg')

get('/') do
  products = Product.all()
  @products_available = []
  products.each() do |product|
    if product.purchase_id() == nil
      @products_available << product
    end
  end
  @products_available
  @purchases = Purchase.all()
  erb(:index)
end

get('/create') do
  erb(:create)
end
