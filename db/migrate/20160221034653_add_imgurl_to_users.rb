class AddImgurlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :img_path, :string, default: "https://s3-ap-northeast-1.amazonaws.com/dic-shibuya/default.png"
  end
end
