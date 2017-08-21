class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, :limit => 255, :null => false
      t.integer :priority, :null => false
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
