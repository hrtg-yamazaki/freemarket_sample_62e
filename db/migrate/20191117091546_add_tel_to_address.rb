class AddTelToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :tel, :string
  end
end
