class CreateProject < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.belongs_to :client, index: true, foreign_key: true, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at
    end
    add_index :projects, :name
    add_index :projects, :deleted_at
  end
end
