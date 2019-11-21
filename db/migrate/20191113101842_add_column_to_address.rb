class AddColumnToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :tel, :integer
  end
end
