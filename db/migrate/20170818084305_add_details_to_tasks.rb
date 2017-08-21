class AddDetailsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :status, :boolean, :default => false
    add_column :tasks, :deadline, :datetime
  end
end
