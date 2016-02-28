class ChangeImageToBinary < ActiveRecord::Migration
 def up
    change_column :users, :image, :binary
  end

  def down
    change_column :users, :image, :string
  end
end
