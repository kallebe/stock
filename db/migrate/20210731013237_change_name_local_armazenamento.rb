class ChangeNameLocalArmazenamento < ActiveRecord::Migration[6.1]
  def change
    add_index :local_armazenamentos, :nome, unique: true
  end
end
