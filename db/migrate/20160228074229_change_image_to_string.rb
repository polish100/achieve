class ChangeImageToString < ActiveRecord::Migration
def up
    change_column :users, :image, :string
  end

  def down
    change_column :users, :image, :binary
  end
end
