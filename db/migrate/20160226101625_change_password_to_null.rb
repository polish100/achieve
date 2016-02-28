class ChangePasswordToNull < ActiveRecord::Migration
 def up
    change_column :users, :encrypted_password, :string, null: true, default: ""
  end

  def down
    change_column :users, :encrypted_password, :string, null: false, default: ""
  end
end
