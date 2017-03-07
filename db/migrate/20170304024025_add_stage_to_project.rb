class AddStageToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :stage, :int, null: false, default: 1
  end
end
