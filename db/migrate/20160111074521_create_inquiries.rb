class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.strings :name
      t.strings :email
      t.text :message
      t.timestamps null: false
    end
  end
end
