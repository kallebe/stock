class Produto < ApplicationRecord
  has_many :movimentacaos, dependent: :delete_all
  has_many :local_armazenamentos, through: :movimentacaos

  validates :nome, presence: { message: 'Nome do produto deve ser informado.' }
  validates :nome, uniqueness: true
  validates :nome, length: {
    maximum: 20,
    too_long: 'Nome do local de armazenamento deve ter no máximo %<count>s caracteres.'
  }
end
