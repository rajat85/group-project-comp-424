class CreateTheResources < ActiveRecord::Migration[6.0]
  def change
    create_table :the_resources do |t|
      t.datetime :password_changed_at
      t.string :unique_session_id
      t.datetime :last_activity_at
      t.datetime :expired_at
    end
    add_index :the_resources, :password_changed_at
    add_index :the_resources, :last_activity_at
    add_index :the_resources, :expired_at
  end
end