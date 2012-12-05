class CreateContactsTable < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.boolean :done
      t.integer :user_id

      t.timestamps
    end
  end
end
