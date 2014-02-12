class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.text :content
      t.references :exp, index: true
      t.references :dst, index: true

      t.timestamps
    end
  end
end
