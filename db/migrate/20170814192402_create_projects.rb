class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, :limit => 255, :null => false
      t.string :flag, :limit => 7, :null => false

      t.timestamps null: false
    end
  end
end
