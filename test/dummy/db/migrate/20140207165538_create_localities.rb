class CreateLocalities < ActiveRecord::Migration
  def change
    create_table :localities do |t|
      t.string :name
      t.string :zip
      t.references :city, index: true, null: false
      t.references :country, index: true, null: false

      t.timestamps
    end
  end
end
