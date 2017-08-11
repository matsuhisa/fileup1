class CreatePostImages < ActiveRecord::Migration[5.1]
  def change
    create_table :post_images do |t|
      t.string :file_name
      t.string :content_type
      t.integer :user_id

      t.timestamps
    end
  end
end
