class CreateClient < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :contact_name
      t.string :contact_phone
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :deleted_at
    end
    add_index :clients, :name
    add_index :clients, :deleted_at
  end
end
