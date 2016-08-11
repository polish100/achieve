class ChangeColumnDefaultOfMessages < ActiveRecord::Migration
  def up
    change_column_default(:messages, :read, false)
  end

  def down
    change_column_default(:messages, :read, nil)
  end
end
