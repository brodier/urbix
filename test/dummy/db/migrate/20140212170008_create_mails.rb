class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.text :content
      t.references :exp, index: true, null: false
      t.references :dst, index: true, null: false

      t.timestamps
    end
  end
end
