class RenamePrefectureColumnToAddress < ActiveRecord::Migration[5.1]
  def change
    rename_column :addresses, :prefecture, :prefecture_id
  end
end
