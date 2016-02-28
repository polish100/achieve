class AddImgurlupdatedToUsers < ActiveRecord::Migration
  def up
    add_column :users, :img_path_updated, :string, default: ""
  end

  def down
    remove_column :users, :img_path_updated, :string, default: ""
  end
end
