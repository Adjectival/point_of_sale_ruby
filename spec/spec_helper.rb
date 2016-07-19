ENV['RACK_ENV'] = 'test'

require("rspec")
require('pg')
require('sinatra/activerecord')
require('purchase')
require('product')
require('pry')

RSpec.configure do |config|
  config.after(:each) do
    Purchase.all.each do |purchase|
      purchase.destroy
    end
    Product.all.each do |product|
      product.destroy
    end
  end

end
