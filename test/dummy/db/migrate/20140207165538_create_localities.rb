class CreateLocalities < ActiveRecord::Migration
  def change
    create_table :localities do |t|
      t.string :name
      t.string :zip
      t.references :city, index: true
      t.references :country, index: true

      t.timestamps
    end
  end
end
