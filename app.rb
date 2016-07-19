require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('sinatra/activerecord')
require('./lib/purchase')
require('./lib/product')
require('pg')
require 'pry'

get('/') do
  @products = Product.all()
  @products_available = []
  @products.each() do |product|
    if product.purchase_id() == nil
      @products_available << product
    end
  end
  @products_available
  @products_sold = []
  @products.each() do |product|
    if product.purchase_id() != nil
      @products_sold << product
    end
  end
  @purchase_ids = []
  @products_sold.each() do |product|
    purchase_id = product.purchase_id()
    @purchase_ids << Purchase.find(purchase_id)
  end
  @purchase_ids
  @purchases = Purchase.all()
  erb(:index)
end

get('/create') do
  erb(:create)
end

post('/create_purchase') do
  purchase_name = params.fetch("purchase_name")
  @purchase = Purchase.create({:name => purchase_name})
  erb(:create)
end

post('/create_product') do
  product_name = params.fetch("product_name")
  product_price = params.fetch("product_price").to_f()
  @product = Product.create({:name => product_name, :price => product_price})
  erb(:create)
end

patch('/add_products_to_purchase') do
  products = []
  product_ids = params.fetch("product_ids")
  purchase_id = params.fetch("buy_these").to_i()
  product_ids.each() do |product_id|
    products << Product.find(product_id)
  end
  products.each() do |product|
    product.update({:purchase_id => purchase_id})
  end
redirect to('/')
end

get('/purchase/:id') do
  purchase_id = params.fetch('id').to_i
  @purchase = Purchase.find(purchase_id)
  all_products = Product.all()
  @products = []
  all_products.each() do |product|
    if product.purchase_id() == purchase_id
      @products << product
    end
  end
  @products
  erb(:purchase_info)
end

get('/product/:id') do
  product_id = params.fetch('id').to_i
  @product_deleted = Product.find(product_id)
  @product_deleted.destroy()
  @products = Product.all()
  @purchases = Purchase.all()
  @products_available = []
  @products.each() do |product|
    if product.purchase_id() == nil
      @products_available << product
    end
  end
  @products_sold = []
  @products.each() do |product|
    if product.purchase_id() != nil
      @products_sold << product
    end
  end
  @purchase_ids = []
  @products_sold.each() do |product|
    purchase_id = product.purchase_id()
    @purchase_ids << Purchase.find(purchase_id)
  end
  @purchase_ids
  @products_available
  erb(:index)
end

delete("/delete_purchase") do
  purchase_to_delete = Purchase.find(params.fetch("delete_this").to_i)
  purchase_to_delete.destroy
  redirect("/")
end
