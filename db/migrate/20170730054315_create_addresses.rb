class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.integer :prefecture
      t.string :municipality

      t.timestamps
    end
  end
end
