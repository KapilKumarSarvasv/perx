class CreateRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :rewards do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
  end
end
