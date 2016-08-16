class ChangeColumnDefaultOfNotifications < ActiveRecord::Migration
  def up
    change_column_default(:notifications, :read, false)
  end

  def down
    change_column_default(:notifications, :read, nil)
  end
end
