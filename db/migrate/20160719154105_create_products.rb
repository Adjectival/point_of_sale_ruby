class CreateProducts < ActiveRecord::Migration
  def change
    create_table(:products) do |t|
      t.column(:name, :varchar)
      t.column(:purchase_id, :int)
      t.column(:price, :float)
    end
  end
end
