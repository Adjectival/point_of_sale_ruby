class Product < ActiveRecord::Base
  belongs_to(:purchase)
  after_destroy(:display_destroy_msg)

private
  define_method(:display_destroy_msg) do
    puts "#{self.name} has been deleted!"
  end
end
