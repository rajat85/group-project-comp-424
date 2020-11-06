class AddPasswordChangedAtToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :password_changed_at, :datetime
    add_index :users, :password_changed_at
    add_column :users, :unique_session_id, :string, :limit => 20
    add_column :users, :last_activity_at, :datetime
    add_index :users, :last_activity_at
    add_column :users, :expired_at, :datetime
    add_index :users, :expired_at
  end
end
