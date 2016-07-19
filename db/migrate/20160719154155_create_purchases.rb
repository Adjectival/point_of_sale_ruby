class CreatePurchases < ActiveRecord::Migration
  def change
    create_table(:purchases) do |t|
      t.column(:name, :varchar)
      t.column(:sum, :float)

      t.timestamps()
    end
  end
end
