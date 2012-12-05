class CreateAsks < ActiveRecord::Migration
  def change
    create_table :asks do |t|
      t.string :description
      t.integer :category
      t.boolean :public
      t.boolean :done
      t.boolean :followed_up
      t.integer :helper
      t.integer :user_id

      t.timestamps
    end
  end
end
