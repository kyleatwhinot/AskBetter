class ChangeRememberTokenColumnInUsers < ActiveRecord::Migration
  def up
  	change_column :users, :remember_token, :string, unique: true
  end

  def down
  	change_column :users, :remember_token, :string, unique: false
  end
end
