class Produto < ApplicationRecord
  has_many :movimentacaos

  validates :nome, presence: { message: 'Nome do produto deve ser informado.' }
  validates :nome, uniqueness: true
  validates :nome, length: {
    maximum: 20,
    too_long: 'Nome do local de armazenamento deve ter no máximo %<count>s caracteres.'
  }
end
