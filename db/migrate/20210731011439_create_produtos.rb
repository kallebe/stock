class CreateProdutos < ActiveRecord::Migration[6.1]
  def change
    create_table :produtos do |t|
      t.string :nome, limit: 20

      t.timestamps
    end
  end
end
