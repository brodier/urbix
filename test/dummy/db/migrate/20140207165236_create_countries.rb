class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :a2code
      t.string :a3code
      t.integer :num_code
      t.integer :dial_code

      t.timestamps
    end
  end
end
