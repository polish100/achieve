class AddSubjectInquiries < ActiveRecord::Migration
  def up
    add_column :inquiries, :subject, :string, default: ""
  end

  def down
    remove_column :inquiries, :subject, :string, default: ""
  end
end
