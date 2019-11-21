class RemoveTelFromAddress < ActiveRecord::Migration[5.2]
  def change
    remove_column :addresses, :tel, :integer
  end
end
