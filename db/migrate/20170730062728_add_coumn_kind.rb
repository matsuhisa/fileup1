class AddCoumnKind < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :kind_id, :integer, null: false, default: 1
  end
end
