class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.float :amount
      t.string :country

      t.timestamps
    end
    add_index :products, :name
    add_index :products, :amount
    add_index :products, :country
  end
end
