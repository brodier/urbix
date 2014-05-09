class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.references :locality, index: true, null: false

      t.timestamps
    end
  end
end
