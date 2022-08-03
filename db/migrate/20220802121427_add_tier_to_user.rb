class AddTierToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :tier, :string
    add_index :users, :tier
  end
end
