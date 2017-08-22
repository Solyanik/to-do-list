class AddDeadlineExpiredToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :deadline_expired, :boolean, :default => false
  end
end
