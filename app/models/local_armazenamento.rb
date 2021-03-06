class LocalArmazenamento < ApplicationRecord
  has_many :movimentacaos, dependent: :delete_all
  has_many :produtos, through: :movimentacaos

  validates :nome, presence: { message: 'Nome do local de armazenamento deve ser informado.' }
  validates :nome, uniqueness: true
  validates :nome, length: {
    maximum: 20,
    too_long: 'Nome do local de armazenamento deve ter no máximo %<count>s caracteres.'
  }
end
