class ChangeNameProduto < ActiveRecord::Migration[6.1]
  def change
    add_index :produtos, :nome, unique: true
  end
end
