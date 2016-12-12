class CreateClient < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :contact_name, null: false
      t.string :contact_phone
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at
    end
    add_index :clients, :name
    add_index :clients, :deleted_at
  end
end
